package com.bounswe2020group3.paperlayer.main

import timber.log.Timber

class MainPresenter(view: MainContract.View)
  : MainContract.Presenter {

  private var view: MainContract.View? = view

  override fun onDestroy() {
    this.view = null
  }

  override fun onViewCreated() {
    Timber.d("onViewCreated")
  }

}
