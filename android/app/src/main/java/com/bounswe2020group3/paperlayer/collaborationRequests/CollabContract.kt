package com.bounswe2020group3.paperlayer.collaborationRequests

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.data.user.User
import com.bounswe2020group3.paperlayer.home.HomeContract
import com.bounswe2020group3.paperlayer.home.data.CollaborationRequest
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.request.RequestItem
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.*

class CollabContract {
    interface CollabPresenter : Mvp.Presenter<CollabContract.CollabView> {
        fun setView(eventView: HomeContract.EventView)
        fun showMessage(message: String)
        fun fetchRequests(ownerId : Int)
        fun subscribeAuthToken()

        fun onAcceptButtonClick(item: RequestItem, position: Int )
        fun onRejectButtonClick(item: RequestItem, position: Int )
    }
    interface CollabView: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)
        var projectId  : Int
        fun resetItemList()
        fun submitItemList()
        fun addItem(item : RequestItem)
        fun removeItem(item : RequestItem)

    }
    interface Model {
        fun getAuthToken(): BehaviorSubject<AuthToken>
        fun fetchRequests( projectId: Int) : Observable<List<CollaborationRequest>>
        fun acceptRequest( collabId : Int) : Completable
        fun rejectRequest( collabId : Int) : Completable
        fun getUser(userId : Int) : Observable<User>


    }
    interface CollabService{
        @GET("/api/collaboration_requests/")
        fun fetchRequests(@Query("to_project__id") projectId: Int) : Observable<List<CollaborationRequest>>
        @POST("/api/collaboration_requests/{id}/accept_collaboration/")
        fun acceptRequest(@Header("Authorization") authorization: String, @Path("id") collabId : Int) : Completable
        @POST("/api/collaboration_requests/{id}/reject_collaboration/")
        fun rejectRequest(@Header("Authorization") authorization: String,@Path("id") collabId : Int) : Completable
    }
    interface UserService{
        @GET("/api/users/{id}/")
        fun getUser(@Path("id") userId : Int) : Observable<User>
        @GET("/api/users/{userId}/")
        fun getUser(@Header("Authorization") authorization: String, @Path("userId") userId: Int): Single<User>
    }

}