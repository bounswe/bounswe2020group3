package com.bounswe2020group3.paperlayer.profile

class ProfilePresenter(view: ProfileContract.View): ProfileContract.Presenter {

    private var view: ProfileContract.View? = view

    override fun onDestroy() {
        this.view = null
    }

}