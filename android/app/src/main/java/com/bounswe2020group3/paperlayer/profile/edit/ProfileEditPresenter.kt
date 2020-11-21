package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.profile.common.ProfileCommonPresenter

class ProfileEditPresenter(view: ProfileEditContract.View): ProfileCommonPresenter(view), ProfileEditContract.Presenter {

    private var view: ProfileEditContract.View? = view

    override fun onDestroy() {
        super.onDestroy()
        this.view = null
    }
}