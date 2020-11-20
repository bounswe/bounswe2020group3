package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView

interface ProfileEditContract {
    interface Presenter: BasePresenter {
    }

    interface View: BaseView<Presenter> {
    }
}