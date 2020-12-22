package com.bounswe2020group3.paperlayer.profile.follow

import com.bounswe2020group3.paperlayer.data.follow.Follow
import com.bounswe2020group3.paperlayer.data.follow.FollowType
import com.bounswe2020group3.paperlayer.mvp.Mvp
import io.reactivex.Observable
import retrofit2.http.*

interface FollowContract {
    interface Presenter : Mvp.Presenter<View> {
        fun loadFollowList(userId: Int?, type: FollowType?)
    }

    interface View : Mvp.View {
        fun updateFollowListUI(followList: List<Follow>)
        fun navigateToUser()
    }

    interface Model {
        fun getFollowerList(userId: Int?): Observable<List<Follow>>
        fun getFollowingList(userId: Int?): Observable<List<Follow>>
    }

    interface Service {
        @GET("/api/follow/")
        fun getFollowerList(
            @Header("Authorization") authorization: String,
            @Query("to_user__id") userId: Int
        ): Observable<List<Follow>>

        @GET("/api/follow/")
        fun getFollowingList(
            @Header("Authorization") authorization: String,
            @Query("from_user__id") userId: Int
        ): Observable<List<Follow>>
    }
}