package com.bounswe2020group3.paperlayer.login

import android.widget.EditText
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R

class LoginPresenter: LoginContract.Presenter {

    private lateinit var mView: LoginContract.View

    override fun onViewCreated() {
        TODO("Not yet implemented")
    }

    override fun setView(view: LoginContract.View) {
        this.mView =view
    }

    override fun showToast(message: String) {
        TODO("Not yet implemented")
    }

    override fun created() {
        this.mView.bindViews()
        this.mView.initOnClicks()

    }

    override fun onLoginButtonClicked(mailEditText: EditText, passwordEditText: EditText) {
        val userEmail=mailEditText.text.toString()
        val userPassword=passwordEditText.text.toString()
        //Model is not implemented yet
        //Ex: AuthenticationSystem.check(userEmail,userPassword)
        mailEditText.text.clear()
        passwordEditText.text.clear()
        //Navigation must be changed to profile page after profile page created
        Navigation.findNavController(mView.getLayout()).navigate(R.id.navigateToRegister)
    }

    override fun onRegisterButtonClicked(mailEditText: EditText, passwordEditText: EditText) {
        mailEditText.text.clear()
        passwordEditText.text.clear()
        Navigation.findNavController(mView.getLayout()).navigate(R.id.navigateToRegister)
    }

    override fun onGuestButtonClicked(mailEditText: EditText, passwordEditText: EditText) {
        //Navigation must be changed to guest page after guest page created
        Navigation.findNavController(mView.getLayout()).navigate(R.id.navigateToRegister)
    }

}