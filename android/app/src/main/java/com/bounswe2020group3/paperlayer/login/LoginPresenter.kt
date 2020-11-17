package com.bounswe2020group3.paperlayer.login

import android.widget.EditText
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.fragment_login.view.*

class LoginPresenter: LoginContract.Presenter {

    private lateinit var view: LoginContract.View

    override fun onViewCreated() {
        TODO("Not yet implemented")
    }

    override fun setView(view: LoginContract.View) {
        this.view =view
    }

    override fun showToast(message: String) {
        TODO("Not yet implemented")
    }

    override fun created() {
        this.view.initOnClicks()
    }

    override fun onLoginButtonClicked(userEmail: String, userPassword: String) {
        //val userEmail=mailEditText.text.toString()
        //val userPassword=passwordEditText.text.toString()
        //Model is not implemented yet
        //Ex: AuthenticationSystem.check(userEmail,userPassword)
        view.resetEditText()
        //Navigation must be changed to profile page after profile page created
        Navigation.findNavController(view.getLayout()).navigate(R.id.navigateToRegister)
    }

    override fun onRegisterButtonClicked(userEmail: String, userPassword: String) {
        view.resetEditText()
        Navigation.findNavController(view.getLayout()).navigate(R.id.navigateToRegister)
    }

    override fun onGuestButtonClicked(userEmail: String, userPassword: String) {
        view.resetEditText()
        //Navigation must be changed to guest page after guest page created
        Navigation.findNavController(view.getLayout()).navigate(R.id.navigateToRegister)
    }

}