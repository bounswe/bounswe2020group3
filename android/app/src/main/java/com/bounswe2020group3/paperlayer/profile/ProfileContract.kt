package com.bounswe2020group3.paperlayer.profile

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView

interface ProfileContract {
    interface Presenter: BasePresenter {
    }

    interface View: BaseView<Presenter> {
    }
}