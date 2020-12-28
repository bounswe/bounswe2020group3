package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.data.user.Profile
import com.bounswe2020group3.paperlayer.data.user.User
import okhttp3.MediaType
import java.io.File

interface ProfileEditContract {
    interface Presenter : Mvp.Presenter<View> {
        fun subscribeUser()
        fun loadUser()
        fun updateProfile(updatedProfile: Profile)
        fun getUserData(): User?
        fun updateProfilePicture(profileId: Int, file: File, type: MediaType)
    }

    interface View : Mvp.View {
        fun showLoading()
        fun hideLoading()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
        fun updateProfileUI(user: User)
        fun updateProfileUIWithProfile(profile: Profile)
        fun navigateBack()
    }
}