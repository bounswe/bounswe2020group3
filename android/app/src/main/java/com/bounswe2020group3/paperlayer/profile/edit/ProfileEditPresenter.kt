package com.bounswe2020group3.paperlayer.profile.edit

import android.util.Log
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.data.Profile
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class ProfileEditPresenter @Inject constructor(private var model: ProfileContract.Model) : BasePresenter<ProfileEditContract.View>(), ProfileEditContract.Presenter {

    private var userProfileData: Profile? = null

    private var disposable = CompositeDisposable()

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun getUserProfileData(): Profile? {
        return this.userProfileData
    }

    override fun subscribeUserProfile() {
        val userProfileSub = model.getUserProfile().subscribe { profile ->
            view?.updateProfileUI(profile)
            this.userProfileData = profile
        }
        disposable.add(userProfileSub)
    }

    override fun loadUserProfile() {
        Log.d("Dagger", "Profile Presenter: $model")
        view?.showLoading()
        val fetchSub = model.fetchUserProfile().subscribe(
                {
                    view?.hideLoading()
                },
                {
                    view?.hideLoading()
                    view?.showErrorToast("An error occurred while fetching profile. Please try again.")
                }
        )
        disposable.add(fetchSub)
    }

    override fun updateProfile(updatedProfile: Profile) {
        val getProfileObservable = model.updateUserProfile(updatedProfile).subscribe(
                { profile ->
                    view?.updateProfileUI(profile)
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