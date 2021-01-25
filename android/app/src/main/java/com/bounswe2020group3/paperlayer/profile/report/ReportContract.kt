package com.bounswe2020group3.paperlayer.profile.report

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.data.user.User

interface ReportContract {
    interface Presenter : Mvp.Presenter<View> {
        fun sendReport(type: String, userId: Int, description: String?)
    }

    interface View : Mvp.View {
        fun navigateBack()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
    }
}