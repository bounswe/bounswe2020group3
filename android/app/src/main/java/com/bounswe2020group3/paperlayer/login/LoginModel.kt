package com.bounswe2020group3.paperlayer.login

import android.util.Log
import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.data.user.UserCredentials
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Retrofit
import javax.inject.Inject


class LoginModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit) : LoginContract.Model {

    private var modelService: LoginContract.ModelService = retrofit.create(LoginContract.ModelService::class.java)

    override fun authLogin(userCredentials: UserCredentials): Single<AuthToken> {
        Log.d("Test", "Login Model: ${sessionManager}")
        return modelService.authLogin(userCredentials)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doAfterSuccess{ token -> sessionManager.setToken(token)}
    }

    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        return sessionManager.getToken()
    }

}


