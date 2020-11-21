package com.bounswe2020group3.paperlayer.main

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView

interface MainContract {
  interface Presenter : BasePresenter {
    fun onViewCreated()
  }

  interface View : BaseView<Presenter> {
    fun showToast(message: String)
  }
}
