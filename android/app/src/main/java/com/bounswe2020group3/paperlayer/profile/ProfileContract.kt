package com.bounswe2020group3.paperlayer.profile

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.data.user.Profile
import com.bounswe2020group3.paperlayer.data.user.User
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.*

interface ProfileContract {
    interface Presenter: Mvp.Presenter<View> {
        fun subscribeAuthUser()
        fun loadAuthUser()
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
        fun updateAuthUserProfile(updatedProfile: Profile): Single<Profile>
        fun fetchAuthUser(): Single<User>
        fun getAuthUser(): BehaviorSubject<User>
        fun getUser(userId: Int): Single<User>
        fun getUserList(): Observable<List<User>>
    }

    interface Service {
        @GET("/api/profiles/{profileId}/")
        fun getProfile(@Path("profileId") profileId: Int): Single<Profile>

        @PATCH("/api/profiles/{profileId}/")
        fun updateProfile(@Header("Authorization") authorization: String, @Path("profileId") profileId: Int, @Body updatedProfile: Profile): Single<Profile>

        @GET("/api/users/{userId}/")
        fun getUser(@Header("Authorization") authorization: String, @Path("userId") userId: Int): Single<User>

        @GET("/api/users/")
        fun getUserList(): Observable<List<User>>
    }
}