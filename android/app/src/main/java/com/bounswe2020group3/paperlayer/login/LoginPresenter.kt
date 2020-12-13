package com.bounswe2020group3.paperlayer.login


import android.util.Log
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.login.data.UserCredentials
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

private const val TAG = "LoginPresenter"

class LoginPresenter @Inject constructor(private var model: LoginContract.Model) : BasePresenter<LoginContract.View>(), LoginContract.Presenter {

    //Disposable
    private var disposable = CompositeDisposable()

    override fun bind(view: LoginContract.View) {
        super.bind(view)
        this.view?.writeLogMessage("i", TAG, "Login Presenter Created")
        this.view?.initOnClicks()
    }

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun showToast(message: String) {
        this.view?.showToast(message)
    }

    override fun onLoginButtonClicked(userEmail: String, userPassword: String) {
        //Model is not implemented yet
        //Ex: AuthenticationSystem.check(userEmail,userPassword)
        checkAuthentication(userEmail, userPassword)
        this.view?.resetEditText()
    }

    override fun onRegisterButtonClicked(userEmail: String, userPassword: String) {
        this.view?.resetEditText()
        this.view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToRegister) }
    }

    override fun onGuestButtonClicked(userEmail: String, userPassword: String) {
        this.view?.resetEditText()
        //Navigation must be changed to guest page after guest page created
        this.view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToRegister) }
    }

    override fun checkAuthentication(userEmail: String, userPassword: String) {
        this.view?.writeLogMessage("i", TAG, "Checking the Authentication...")
        val userCredentials = UserCredentials(userEmail, userPassword)
        val getTokenObservable = model.authLogin(userCredentials).subscribe(
                { token ->
                    this.view?.writeLogMessage("i", TAG, "Authentication Successful.")
                    this.view?.writeLogMessage("i", TAG, "Token: " + token.token)
                    //Navigation must be changed to profile page after profile page created
                    this.view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.test3) }
                },
                { error ->
                    this.view?.writeLogMessage("e", TAG, "Error in authentication")
                    this.view?.showToast("Wrong username or password!")
                }
        )

        disposable.add(getTokenObservable)
    }


}