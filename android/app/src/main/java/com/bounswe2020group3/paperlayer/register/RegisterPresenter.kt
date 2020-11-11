package com.bounswe2020group3.paperlayer.register

import com.bounswe2020group3.paperlayer.register.RegisterContract
import timber.log.Timber

class RegisterPresenter(view: RegisterContract.View)
    : RegisterContract.Presenter {
    private var view: RegisterContract.View? = view

    override fun onDestroy() {
        this.view = null
    }
    override fun onViewCreated() {
        Timber.d("onViewCreated")
    }

    override fun demo() {
        Timber.d("Demo button tapped!")
        view?.showToast("DEMOOO")
    }
}