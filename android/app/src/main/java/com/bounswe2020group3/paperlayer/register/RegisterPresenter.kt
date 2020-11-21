package com.bounswe2020group3.paperlayer.register

import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.ProfileModel
import com.bounswe2020group3.paperlayer.register.RegisterContract
import com.bounswe2020group3.paperlayer.register.data.Register
import kotlinx.coroutines.flow.callbackFlow
import retrofit2.Callback
import retrofit2.Call
import retrofit2.Response
import timber.log.Timber

class RegisterPresenter(view: RegisterContract.View)
    : RegisterContract.Presenter {
    private var view: RegisterContract.View? = view
    private var model: RegisterContract.Model = RegisterModel()

    override fun onDestroy() {
        this.view = null
    }
    override fun onViewCreated() {
        Timber.d("onViewCreated")
    }

    override fun register(register : Register) {

        view?.showLoading()
        view?.showInfoToast("Fetching the profile...")

        register(register)?.enqueue(object :  Callback<Register> {
            override fun onResponse(call: Call<Register>, response: Response<Register>) {
                if(response.isSuccessful) {

                    view?.navigateToLogin()
                    view?.showToast("Thank you for registering.\n An Email will be sent for you to activate your account")
                }
            }

            override fun onFailure(call: Call<Register>, t: Throwable) {
                view?.showErrorToast("Registration failed")
            }

        } )



    }

}