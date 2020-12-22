package com.bounswe2020group3.paperlayer.profile.user

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.profile.data.User

interface UserContract {
    interface Presenter : Mvp.Presenter<View> {
        fun loadUser(userId: Int)
    }

    interface View : Mvp.View {
        fun navigateBack()
        fun showLoading()
        fun hideLoading()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
        fun updateProfileUI(user: User)
    }
}