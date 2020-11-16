package com.bounswe2020group3.paperlayer.register

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView

interface RegisterContract {
    interface Presenter : BasePresenter {
        fun onViewCreated()
        fun demo()
    }

    interface View : BaseView<Presenter> {
        fun onDemoTap()
        fun showToast(message: String)
    }
}