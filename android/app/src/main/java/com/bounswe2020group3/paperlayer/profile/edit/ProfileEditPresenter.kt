package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.ProfileModel
import com.bounswe2020group3.paperlayer.profile.data.Profile
import io.reactivex.disposables.CompositeDisposable

class ProfileEditPresenter(view: ProfileEditContract.View): ProfileEditContract.Presenter {

    private var view: ProfileEditContract.View? = view
    private var model: ProfileContract.Model = ProfileModel()

    private var userProfileData: Profile? = null

    private var disposable = CompositeDisposable()
    
    override fun onDestroy() {
        this.view = null
        disposable.clear()
    }

    private fun getUserProfileData(): Profile? {
        return this.userProfileData
    }

    override fun subscribeUserProfile() {
        val userProfileSub = model.getUserProfile().subscribe{ profile ->
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
        view?.showInfoToast("Profile will be updated.")
        val getProfileObservable = model.updateUserProfile(updatedProfile).subscribe(
                { profile ->
                    view?.updateProfileUI(profile)
                    view?.hideLoading()
                    view?.showInfoToast("Profile is updated.")
                },
                { error ->
                    view?.hideLoading()
                    view?.showErrorToast("Error while updating the profile")
                }
        )
        disposable.add(getProfileObservable)
    }

    override fun onFirstNameChange(firstname: String) {
        val profile = getUserProfileData()
        if(profile != null) {
            profile.name = firstname
            updateProfile(profile)
        }
    }
}