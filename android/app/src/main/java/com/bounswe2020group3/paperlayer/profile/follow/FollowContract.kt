package com.bounswe2020group3.paperlayer.profile.follow

import com.bounswe2020group3.paperlayer.data.follow.*
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
        fun sendFollow(userId: Int?, toUserId: Int): Observable<Any>
        fun getFollowerList(userId: Int?): Observable<List<Follow>>
        fun getFollowingList(userId: Int?): Observable<List<Follow>>
        fun sendFollowRequest(userId: Int?, toUserId: Int): Observable<Any>
        fun getFollowRequestList(userId: Int?): Observable<List<FollowRequest>>
        fun acceptFollowRequest(followRequestId: Int): Observable<Any>
        fun rejectFollowRequest(followRequestId: Int): Observable<Any>
    }

    interface Service {
        @POST("/api/follow/")
        fun sendFollow(
            @Header("Authorization") authorization: String,
            @Body followCreate: FollowCreate
        ): Observable<Any>

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

        @POST("/api/follow_request/")
        fun sendFollowRequest(
            @Header("Authorization") authorization: String,
            @Body followRequestCreate: FollowRequestCreate
        ): Observable<Any>

        @GET("/api/follow_request/")
        fun getFollowRequestList(
            @Header("Authorization") authorization: String,
            @Query("req_to_user") userId: Int
        ): Observable<List<FollowRequest>>

        @POST("/api/follow_request/{id}/accept_follow/")
        fun acceptFollowRequest(
            @Header("Authorization") authorization: String,
            @Path("id") followRequestId: Int
        ): Observable<Any>

        @POST("/api/follow_request/{id}/reject_follow/")
        fun rejectFollowRequest(
            @Header("Authorization") authorization: String,
            @Path("id") followRequestId: Int
        ): Observable<Any>
    }
}