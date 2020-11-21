package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView
import com.bounswe2020group3.paperlayer.profile.common.ProfileCommonContract
import com.bounswe2020group3.paperlayer.profile.data.Profile
import io.reactivex.Single
import retrofit2.http.Body
import retrofit2.http.PATCH
import retrofit2.http.Path

interface ProfileEditContract {
    interface Presenter: BasePresenter {
    }

    interface View: BaseView<Presenter> {
    }

    interface Model: ProfileCommonContract.Model {
        fun updateProfile(profileId: Int, updatedProfile: Profile): Single<Profile>
    }

    interface Service: ProfileCommonContract.Service {
        @PATCH("/api/profiles/{profileId}/")
        fun updateProfile(@Path("profileId") profileId: Int, @Body updatedProfile: Profile): Single<Profile>
    }
}