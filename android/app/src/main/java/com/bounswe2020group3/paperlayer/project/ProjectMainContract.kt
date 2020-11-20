package com.bounswe2020group3.paperlayer.project

interface ProjectMainContract {

    interface Presenter {
        fun onViewCreated()
        fun setView(view: View)
        fun showMessage(message: String)
        fun created()

        fun onLoginButtonClicked(userEmail: String, userPassword: String)
        fun onRegisterButtonClicked(userEmail: String, userPassword: String)
        fun onGuestButtonClicked(userEmail: String, userPassword: String)
    }

    interface View{
        fun initOnClicks()
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun resetEditText()
    }


}