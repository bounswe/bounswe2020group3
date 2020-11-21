package com.bounswe2020group3.paperlayer.profile

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView
import com.bounswe2020group3.paperlayer.profile.common.ProfileCommonContract
import com.bounswe2020group3.paperlayer.profile.data.Profile
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Path

interface ProfileContract {
    interface Presenter: BasePresenter, ProfileCommonContract.Presenter {
    }

    interface View: BaseView<Presenter>, ProfileCommonContract.View {
    }

    interface Model: ProfileCommonContract.Model {
    }

    interface Service: ProfileCommonContract.Service {
    }
}