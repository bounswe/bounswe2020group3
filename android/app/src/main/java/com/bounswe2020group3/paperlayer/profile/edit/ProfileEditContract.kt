package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView
import com.bounswe2020group3.paperlayer.profile.data.Profile

interface ProfileEditContract {
    interface Presenter : BasePresenter {
        fun subscribeUserProfile()
        fun loadUserProfile()
        fun updateProfile(updatedProfile: Profile)
        fun onFirstNameChange(firstName: String)
    }

    interface View : BaseView<Presenter> {
        fun showLoading()
        fun hideLoading()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
        fun updateProfileUI(profile: Profile)
    }
}