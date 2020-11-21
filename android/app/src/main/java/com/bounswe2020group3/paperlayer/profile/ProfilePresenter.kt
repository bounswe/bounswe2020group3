package com.bounswe2020group3.paperlayer.profile

import com.bounswe2020group3.paperlayer.profile.common.ProfileCommonPresenter

open class ProfilePresenter(view: ProfileContract.View) : ProfileCommonPresenter(view), ProfileContract.Presenter {

    private var view: ProfileContract.View? = view

    override fun onDestroy() {
        super.onDestroy()
        this.view = null
    }

}