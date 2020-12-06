package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.profile.data.User
import com.bounswe2020group3.paperlayer.project.ProjectMainContract
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Retrofit
import javax.inject.Inject

class InviteModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit): InviteContract.Model {
    private var userService: InviteContract.UserService = retrofit.create(InviteContract.UserService::class.java)

    override fun getAllUsers(): Observable<List<User>>? {
        return userService.getUsers()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        return sessionManager.getToken()
    }
}