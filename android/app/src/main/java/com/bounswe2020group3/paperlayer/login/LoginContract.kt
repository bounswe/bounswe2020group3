package com.bounswe2020group3.paperlayer.login

import android.view.View
import android.widget.EditText
import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.login.data.UserCredentials
import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.Observable
import io.reactivex.Single
import retrofit2.Call
import retrofit2.http.*


interface LoginContract {

    interface Presenter {
        fun setView(view:View)
        fun showToast(message: String)
        fun created()
        fun onDestroyed()

        fun onLoginButtonClicked(userEmail: String, userPassword: String)
        fun onRegisterButtonClicked(userEmail: String, userPassword: String)
        fun onGuestButtonClicked(userEmail: String, userPassword: String)
        fun checkAuthentication(userEmail: String, userPassword: String)

    }

    interface View{
        fun initOnClicks()
        fun getLayout(): android.view.View
        fun resetEditText()

        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)
    }

    interface Model {
        fun getToken(userCredentials: UserCredentials): Observable<AuthToken>
    }

    interface ModelService {
        @POST("/api/auth/")
        fun getToken(@Body userCredentials:UserCredentials): Observable<AuthToken>
    }

}