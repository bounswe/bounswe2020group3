package com.bounswe2020group3.paperlayer.login

import android.database.Observable
import android.widget.Toast
import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.login.data.UserCredentials
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers


class LoginModel:LoginContract.Model {

    private var modelService: LoginContract.ModelService = RetrofitProvider.instance.create(LoginContract.ModelService::class.java)

    override fun getToken(userCredentials: UserCredentials): io.reactivex.Observable<AuthToken> {
        return modelService.getToken(userCredentials)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }


}


