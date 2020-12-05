package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.project.ProjectMainContract
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Retrofit
import javax.inject.Inject

class InviteModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit): InviteContract.Model {
    override fun getAllUsers(ownerId: Int): Observable<List<Project>> {
        TODO("Not yet implemented")
    }
    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        TODO("Not yet implemented")
    }
}