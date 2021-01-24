package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.data.user.User
import com.bounswe2020group3.paperlayer.invite.data.InviteRequest
import com.bounswe2020group3.paperlayer.invite.data.InviteResponse
import com.bounswe2020group3.paperlayer.invite.data.CollaborationInvite

import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Retrofit
import javax.inject.Inject

class InviteModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit): InviteContract.Model {
    private var userService: InviteContract.UserService = retrofit.create(InviteContract.UserService::class.java)
    override fun inviteUsers(inviteRequest: InviteRequest): Observable<CollaborationInvite> {
        val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"

        return userService.inviteUsers(authToken,inviteRequest)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getAllUsers(): Observable<List<User>>? {
        return userService.getUsers()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        return sessionManager.getToken()
    }

    override fun getInvited(projectId: Int):  Observable<List<CollaborationInvite>> {
        return userService.getInvited(projectId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun uninvite(invite_id: Int) : Completable {
        val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"

        return userService.deleteInvite(authToken,invite_id)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())    }

    override fun getRecommendedUsers(projectId : Int): Observable<List<User>>? {
        return userService.getRecommendedUsers(projectId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }
}