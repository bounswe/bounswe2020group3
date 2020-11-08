package com.bounswe2020group3.paperlayer

interface MainContract {
  interface Presenter : BasePresenter {
    fun onViewCreated()
    fun demo()
  }

  interface View : BaseView<Presenter> {
    fun onDemoTap()
    fun showToast(message: String)
  }
}
