package com.bounswe2020group3.paperlayer.util

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import io.reactivex.subjects.BehaviorSubject
import javax.inject.Inject

class SessionManager @Inject constructor(): Session {

    private var authToken: BehaviorSubject<AuthToken> = BehaviorSubject.create()
    
    override fun getToken() = authToken

    override fun setToken(token: AuthToken) {
        this.authToken.onNext(token)
    }
}