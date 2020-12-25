package com.bounswe2020group3.paperlayer.profile.follow

import com.bounswe2020group3.paperlayer.data.follow.Follow
import com.bounswe2020group3.paperlayer.data.follow.FollowCreate
import com.bounswe2020group3.paperlayer.data.follow.FollowRequest
import com.bounswe2020group3.paperlayer.data.follow.FollowRequestCreate
import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Response
import retrofit2.Retrofit
import java.lang.Exception
import javax.inject.Inject

class FollowModel @Inject constructor(
    retrofit: Retrofit,
    private val sessionManager: Session
) : FollowContract.Model {

    private var followService: FollowContract.Service =
        retrofit.create(FollowContract.Service::class.java)

    override fun getAuthToken(): AuthToken {
        return sessionManager.getToken().value ?: throw Exception("No user found")
    }

    private fun getSafeUserId(userId: Int?): Int {
        var safeUserId = userId
        if (safeUserId == null || safeUserId == 0)
            safeUserId = getAuthToken().id
        return safeUserId
    }

    override fun sendFollow(toUserId: Int): Observable<Any> {
        val userId = getAuthToken().id
        val followRequestCreate = FollowCreate(
            fromUser = userId,
            toUser = toUserId
        )
        val authorization = "Token ${getAuthToken().token}"
        return followService.sendFollow(authorization, followRequestCreate)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getFollowerList(userId: Int?): Observable<List<Follow>> {
        val safeUserId = getSafeUserId(userId)
        val authorization = "Token ${getAuthToken().token}"
        return followService.getFollowerList(authorization, safeUserId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getFollowingList(userId: Int?): Observable<List<Follow>> {
        val safeUserId = getSafeUserId(userId)
        val authorization = "Token ${getAuthToken().token}"
        return followService.getFollowingList(authorization, safeUserId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getFollowRequestList(): Observable<List<FollowRequest>> {
        val userId = getAuthToken().id
        val authorization = "Token ${getAuthToken().token}"
        return followService.getFollowRequestList(authorization, userId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun sendFollowRequest(toUserId: Int): Observable<Any> {
        val userId = getAuthToken().id
        val followRequestCreate = FollowRequestCreate(
            requestFromUser = userId,
            requestToUser = toUserId
        )
        val authorization = "Token ${getAuthToken().token}"
        return followService.sendFollowRequest(authorization, followRequestCreate)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getFollowRequestList(userId: Int?): Observable<List<FollowRequest>> {
        val safeUserId = getSafeUserId(userId)
        val authorization = "Token ${getAuthToken().token}"
        return followService.getFollowRequestList(authorization, safeUserId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    override fun acceptFollowRequest(followRequestId: Int, fromUserId: Int): Observable<Response<Void>> {
        val authorization = "Token ${getAuthToken().token}"
        val userId = getAuthToken().id
        val acceptBody = FollowRequestCreate(
                requestFromUser = fromUserId,
                requestToUser = userId
        )
        return followService.acceptFollowRequest(authorization, followRequestId, acceptBody)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    override fun rejectFollowRequest(followRequestId: Int, fromUserId: Int): Observable<Response<Void>> {
        val authorization = "Token ${getAuthToken().token}"
        val userId = getAuthToken().id
        val rejectBody = FollowRequestCreate(
                requestFromUser = fromUserId,
                requestToUser = userId
        )
        return followService.rejectFollowRequest(authorization, followRequestId, rejectBody)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }
}