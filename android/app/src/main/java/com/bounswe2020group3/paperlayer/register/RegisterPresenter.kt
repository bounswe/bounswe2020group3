package com.bounswe2020group3.paperlayer.register

import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.ProfileModel
import com.bounswe2020group3.paperlayer.register.RegisterContract
import com.bounswe2020group3.paperlayer.register.data.Register
import io.reactivex.disposables.CompositeDisposable
import kotlinx.coroutines.flow.callbackFlow
import retrofit2.Callback
import retrofit2.Call
import retrofit2.Response
import timber.log.Timber

class RegisterPresenter(view: RegisterContract.View)
    : RegisterContract.Presenter {
    private var view: RegisterContract.View? = view
    private var model: RegisterContract.Model = RegisterModel()
    private var disposable = CompositeDisposable()
    override fun onDestroy() {
        this.view = null
        disposable.clear()

    }
    override fun onViewCreated() {
        Timber.d("onViewCreated")
    }


    override fun register(register : Register) {

        view?.showInfoToast("Opening Register Page...")
        val getProfileObservable = model.register(register).subscribe(
            { profile ->
                //view?.updateProfileUI(profile)
                view?.showInfoToast("Register is complete. You can now login")
                view?.hideLoading()
                view?.navigatetologin()

            },
            { error ->

                view?.showErrorToast(error.message+"Error while registering. Please try again another time")
            }
        )
        disposable.add(getProfileObservable)




    }

}