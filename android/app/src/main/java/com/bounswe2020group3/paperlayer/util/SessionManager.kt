package com.bounswe2020group3.paperlayer.util

import com.bounswe2020group3.paperlayer.login.data.AuthToken
import io.reactivex.subjects.BehaviorSubject
import javax.inject.Inject

class SessionManager @Inject constructor() {

    private var authToken: BehaviorSubject<AuthToken> = BehaviorSubject.create()

    fun getToken() = authToken

    fun setToken(token: AuthToken) {
        this.authToken.onNext(token)
    }
}