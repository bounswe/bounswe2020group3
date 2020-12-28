package com.bounswe2020group3.paperlayer.collaborationRequests

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.data.user.User
import com.bounswe2020group3.paperlayer.home.HomeContract
import com.bounswe2020group3.paperlayer.home.data.CollaborationRequest
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Retrofit
import javax.inject.Inject

class CollabModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit): CollabContract.Model {
    private var collabService: CollabContract.CollabService = retrofit.create(CollabContract.CollabService::class.java)
    private var userService: CollabContract.UserService = retrofit.create(CollabContract.UserService::class.java)

    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        return sessionManager.getToken()
    }

    override fun fetchRequests(projectId: Int): Observable<List<CollaborationRequest>> {
        return collabService.fetchRequests(projectId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun acceptRequest(collabId: Int): Completable {
        val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"

        return collabService.acceptRequest(authToken,collabId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun rejectRequest( collabId: Int): Completable {
        val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"

        return collabService.rejectRequest(authToken,collabId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getUser(userId: Int): Observable<User> {
        return userService.getUser(userId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}