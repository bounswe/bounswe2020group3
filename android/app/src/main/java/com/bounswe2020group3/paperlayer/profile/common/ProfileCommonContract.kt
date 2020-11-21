package com.bounswe2020group3.paperlayer.profile.common

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView
import com.bounswe2020group3.paperlayer.profile.data.Profile
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Path

interface ProfileCommonContract {
    interface Presenter{
        fun fetchProfile(profileId: Int)
    }

    interface View {
        fun showLoading()
        fun hideLoading()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
        fun updateProfileUI(profile: Profile?)
    }

    interface Model {
        fun getProfile(profileId: Int): Single<Profile>
    }

    interface Service {
        @GET("/api/profiles/{profileId}/")
        fun getProfile(@Path("profileId") profileId: Int): Single<Profile>
    }
}