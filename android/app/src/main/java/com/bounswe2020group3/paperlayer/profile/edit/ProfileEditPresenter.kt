package com.bounswe2020group3.paperlayer.profile.edit

class ProfileEditPresenter(view: ProfileEditContract.View): ProfileEditContract.Presenter {

    private var view: ProfileEditContract.View? = view

    override fun onDestroy() {
        this.view = null
    }
}