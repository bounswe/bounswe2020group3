package com.bounswe2020group3.paperlayer

import android.util.Log
import timber.log.Timber

class MainPresenter(view: MainContract.View,
                    dependencyInjector: DependencyInjector)
  : MainContract.Presenter {

  private var view: MainContract.View? = view

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
