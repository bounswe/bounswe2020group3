package com.bounswe2020group3.paperlayer.profile.edit

import android.util.Log
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.data.user.User
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class ProfileEditPresenter @Inject constructor(private var model: ProfileContract.Model) : BasePresenter<ProfileEditContract.View>(), ProfileEditContract.Presenter {

    private var userData: User? = null

    private var disposable = CompositeDisposable()

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun subscribeUser() {
        val userSub = model.getAuthUser().subscribe { user ->
            view?.updateProfileUI(user)
            this.userData = user
        }
        disposable.add(userSub)
    }

    override fun loadUser() {
        Log.d("Dagger", "Profile Presenter: $model")
        view?.showLoading()
        try {
            val fetchSub = model.fetchAuthUser().subscribe(
                    {
                        view?.hideLoading()
                    },
                    {
                        view?.hideLoading()
                        view?.showErrorToast("An error occurred while fetching profile. Please try again.")
                    }
            )
            disposable.add(fetchSub)
        } catch (e: Exception) {

        }

        view?.showLoading()
    }

    override fun getUserData(): User? {
        return this.userData
    }

    override fun updateProfile(updatedProfile: Profile) {
        val getProfileObservable = model.updateAuthUserProfile(updatedProfile).subscribe(
                { profile ->
                    view?.updateProfileUIWithProfile(profile)
                    view?.navigateBack()
                    view?.showInfoToast("Profile is updated.")
                },
                { error ->
                    view?.showErrorToast("An error occurred while updating the profile. Please try again.")
                }
        )
        disposable.add(getProfileObservable)
    }
}