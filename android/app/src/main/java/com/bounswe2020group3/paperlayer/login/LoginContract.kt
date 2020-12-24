package com.bounswe2020group3.paperlayer.login

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.data.user.UserCredentials
import com.bounswe2020group3.paperlayer.mvp.Mvp
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.*


interface LoginContract {

    interface Presenter: Mvp.Presenter<View> {
        fun showToast(message: String)

        fun onLoginButtonClicked(userEmail: String, userPassword: String)
        fun onRegisterButtonClicked(userEmail: String, userPassword: String)
        fun onGuestButtonClicked(userEmail: String, userPassword: String)
        fun checkAuthentication(userEmail: String, userPassword: String)

    }

    interface View: Mvp.View {
        fun initOnClicks()
        fun getLayout(): android.view.View
        fun resetEditText()

        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)
    }

    interface Model {
        fun authLogin(userCredentials: UserCredentials): Single<AuthToken>
        fun getAuthToken(): BehaviorSubject<AuthToken>
    }

    interface ModelService {
        @POST("/api/auth/")
        fun authLogin(@Body userCredentials: UserCredentials): Single<AuthToken>
    }

}