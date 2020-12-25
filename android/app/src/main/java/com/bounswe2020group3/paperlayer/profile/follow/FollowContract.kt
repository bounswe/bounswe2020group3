package com.bounswe2020group3.paperlayer.profile.follow

import com.bounswe2020group3.paperlayer.data.follow.*
import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.data.user.User
import com.bounswe2020group3.paperlayer.mvp.Mvp
import io.reactivex.Observable
import retrofit2.Response
import retrofit2.http.*

interface FollowContract {
    interface Presenter : Mvp.Presenter<View> {
        fun loadFollowList(userId: Int?, type: FollowType?)
        fun isUserAuthenticatedUser(userId: Int): Boolean
        fun sendFollow(toUserId: Int)
        fun sendFollowRequest(toUserId: Int)
        fun acceptRequest(requestId: Int, fromUserId: Int)
        fun rejectRequest(requestId: Int, fromUserId: Int)
    }

    interface View : Mvp.View {
        fun updateFollowListUI(followList: List<ListableFollow>)
        fun loadList()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
    }

    interface Model {
        fun getAuthToken(): AuthToken
        fun sendFollow(toUserId: Int): Observable<Any>
        fun getFollowerList(userId: Int?): Observable<List<Follow>>
        fun getFollowingList(userId: Int?): Observable<List<Follow>>
        fun getFollowRequestList(): Observable<List<FollowRequest>>
        fun sendFollowRequest(toUserId: Int): Observable<Any>
        fun getFollowRequestList(userId: Int?): Observable<List<FollowRequest>>
        fun acceptFollowRequest(followRequestId: Int, fromUserId: Int): Observable<Response<Void>>
        fun rejectFollowRequest(followRequestId: Int, fromUserId: Int): Observable<Response<Void>>
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
                @Path("id") followRequestId: Int,
                @Body followRequestAccept: FollowRequestCreate
        ): Observable<Response<Void>>

        @POST("/api/follow_request/{id}/reject_follow/")
        fun rejectFollowRequest(
                @Header("Authorization") authorization: String,
                @Path("id") followRequestId: Int,
                @Body followRequestReject: FollowRequestCreate
        ): Observable<Response<Void>>
    }

    interface OnUserClickListener {
        fun onUserClick(user: User)
    }

    interface OnFollowButtonClickListener {
        fun onFollowButtonClick(user: User)
        fun onUnfollowButtonClick(user: User)
        fun onAcceptRequestClick(followRequestId: Int, fromUser: User)
        fun onRejectRequestClick(followRequestId: Int, fromUser: User)
    }
}