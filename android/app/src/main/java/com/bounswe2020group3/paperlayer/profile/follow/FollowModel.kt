package com.bounswe2020group3.paperlayer.profile.follow

import com.bounswe2020group3.paperlayer.data.follow.Follow
import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Retrofit
import java.lang.Exception
import javax.inject.Inject

class FollowModel @Inject constructor(
    private val retrofit: Retrofit,
    private val sessionManager: Session
) : FollowContract.Model {

    private var followService: FollowContract.Service =
        retrofit.create(FollowContract.Service::class.java)

    private fun getAuthToken(): AuthToken {
        return sessionManager.getToken().value ?: throw Exception("No user found")
    }

    override fun getFollowerList(userId: Int?): Observable<List<Follow>> {
        var safeUserId = userId
        if (safeUserId == null || safeUserId == 0)
            safeUserId = getAuthToken().id
        val authorization = "Token ${getAuthToken().token}"
        return followService.getFollowerList(authorization, safeUserId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getFollowingList(userId: Int?): Observable<List<Follow>> {
        var safeUserId = userId
        if (safeUserId == null || safeUserId == 0)
            safeUserId = getAuthToken().id
        val authorization = "Token ${getAuthToken().token}"
        return followService.getFollowingList(authorization, safeUserId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }
}