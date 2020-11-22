package com.bounswe2020group3.paperlayer.login


import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.login.data.UserCredentials
import io.reactivex.disposables.CompositeDisposable

private const val TAG = "LoginPresenter"

class LoginPresenter: LoginContract.Presenter {

    //Login Fragment view
    private lateinit var view: LoginContract.View
    //Model for fetch data
    private var model: LoginContract.Model = LoginModel()
    //Disposable
    private var disposable = CompositeDisposable()

    //set login fragment as a view of login presenter
    override fun setView(view: LoginContract.View) {
        this.view =view
    }

    override fun created() {
        this.view.writeLogMessage("i", TAG,"Login Presenter Created")
        this.view.initOnClicks()
    }

    override fun onDestroyed() {
        disposable.clear()
    }

    override fun showToast(message: String) {
        this.view.showToast(message)
    }

    override fun onLoginButtonClicked(userEmail: String, userPassword: String) {
        //Model is not implemented yet
        //Ex: AuthenticationSystem.check(userEmail,userPassword)
        checkAuthentication(userEmail,userPassword)
        view.resetEditText()
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

    override fun checkAuthentication(userEmail: String, userPassword: String) {
        this.view.writeLogMessage("i", TAG,"Checking the Authentication...")
        var userCredentials = UserCredentials(userEmail,userPassword)
        val getTokenObservable = model.getToken(userCredentials).subscribe(
                { token ->
                    this.view.writeLogMessage("i", TAG,"Authentication Successful.")
                    this.view.writeLogMessage("i",TAG,"Token: " +token.token)
                    //Navigation must be changed to profile page after profile page created
                    // #FIX# id will be given as bundle when backend issue solved
                    Navigation.findNavController(view.getLayout()).navigate(R.id.navigateToProjectMainFromLogin)

                },
                { error ->
                    this.view.writeLogMessage("e", TAG,"Error in authentication")
                    this.view.showToast("Wrong username or password!")
                }
        )


        disposable.add(getTokenObservable)
    }


}