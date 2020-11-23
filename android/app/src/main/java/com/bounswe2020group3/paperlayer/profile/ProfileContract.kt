package com.bounswe2020group3.paperlayer.profile

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.profile.data.User
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.*

interface ProfileContract {
    interface Presenter: Mvp.Presenter<View> {
        fun subscribeUser()
        fun loadUser()
    }

    interface View: Mvp.View{
        fun showLoading()
        fun hideLoading()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
        fun updateProfileUI(user: User)
        fun navigateToLogin()
    }

    interface Model {
        fun updateUserProfile(updatedProfile: Profile): Single<Profile>

        fun fetchUser(): Single<User>
        fun getUser(): BehaviorSubject<User>
    }

    interface Service {
        @GET("/api/profiles/{profileId}/")
        fun getProfile(@Path("profileId") profileId: Int): Single<Profile>

        @PATCH("/api/profiles/{profileId}/")
        fun updateProfile(@Header("Authorization") authorization: String, @Path("profileId") profileId: Int, @Body updatedProfile: Profile): Single<Profile>

        @GET("/api/users/{userId}/")
        fun getUser(@Path("userId") userId: Int): Single<User>
    }
}