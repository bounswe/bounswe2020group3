package com.bounswe2020group3.paperlayer.register

import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
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
import javax.inject.Inject

class RegisterPresenter @Inject constructor(private var model: RegisterContract.Model)  : BasePresenter<RegisterContract.View>(), RegisterContract.Presenter {

    override fun bind(view: RegisterContract.View) {
        super.bind(view)
    }

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }
    private var disposable = CompositeDisposable()

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