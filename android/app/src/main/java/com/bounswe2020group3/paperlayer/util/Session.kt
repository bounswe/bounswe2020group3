package com.bounswe2020group3.paperlayer.util

import com.bounswe2020group3.paperlayer.profile.data.data.AuthToken
import io.reactivex.subjects.BehaviorSubject

interface Session {
    fun getToken(): BehaviorSubject<AuthToken>

    fun setToken(token: AuthToken)
}