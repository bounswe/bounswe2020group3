package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.ProfileModel
import com.bounswe2020group3.paperlayer.profile.data.Profile
import io.reactivex.disposables.CompositeDisposable

class ProfileEditPresenter(view: ProfileEditContract.View) : ProfileEditContract.Presenter {

    private var view: ProfileEditContract.View? = view
    private var model: ProfileContract.Model = ProfileModel()

    private var userProfileData: Profile? = null

    private var disposable = CompositeDisposable()

    override fun onDestroy() {
        this.view = null
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