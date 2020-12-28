package com.bounswe2020group3.paperlayer.util

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import io.reactivex.subjects.BehaviorSubject

interface Session {
    fun getToken(): BehaviorSubject<AuthToken>

    fun setToken(token: AuthToken)
}