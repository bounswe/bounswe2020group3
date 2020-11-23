package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.profile.data.Profile

interface ProfileEditContract {
    interface Presenter : Mvp.Presenter<View> {
        fun subscribeUserProfile()
        fun loadUserProfile()
        fun updateProfile(updatedProfile: Profile)
        fun getUserProfileData(): Profile?
    }

    interface View : Mvp.View {
        fun showLoading()
        fun hideLoading()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
        fun updateProfileUI(profile: Profile)
        fun navigateBack()
    }
}