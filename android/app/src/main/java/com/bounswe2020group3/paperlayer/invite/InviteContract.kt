package com.bounswe2020group3.paperlayer.invite

import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.invite.data.InviteRequest
import com.bounswe2020group3.paperlayer.invite.data.InviteResponse
import com.bounswe2020group3.paperlayer.invite.data.CollaborationInvite
import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.data.user.User
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.*

interface InviteContract {
    interface Presenter: Mvp.Presenter<View> {
        fun setView(view: View)
        fun showMessage(message: String)

        fun subscribeAuthToken()
        fun fetchAllUsers(ownerId: Int)
        fun OnInviteButtonClicked(Item : InviteCard,position : Int)
    }

    interface View: Mvp.View{
        var projectId : Int
        var recyclerView : RecyclerView
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun cardInviteCheck(id : Int,position : Int)
        fun cardUnInviteCheck(id : Int,position : Int)
        fun resetUserCardlist()
        fun submitUserCardList()
        fun addUserCard(username: String,name : String,expertise: String?,photoURL: String?,id : Int,invited : Boolean)
    }

    interface Model {
        //fun getProject(projectId: Int): Single<Project>
        fun getAllUsers(): Observable<List<User>>?
        fun getAuthToken(): BehaviorSubject<AuthToken>
        fun inviteUsers(inviteRequest: InviteRequest) : Observable<CollaborationInvite>
        fun getInvited(projectId : Int ) :  Observable<List<CollaborationInvite>>
        fun uninvite(invite_id : Int) : Completable
    }

    interface UserService {
        @POST("/api/collaboration_invites/")
        fun inviteUsers(@Header("Authorization") authorization: String, @Body inviteRequest: InviteRequest)  : Observable<CollaborationInvite>

        @GET("/api/collaboration_invites/")
        fun getInvited(@Query("to_project__id") projectId: Int) : Observable<List<CollaborationInvite>>

        @GET("/api/users/")
        fun getUsers(): Observable<List<User>>

        @DELETE("api/collaboration_invites/{id}/")
        fun deleteInvite(@Header("Authorization") authorization: String,@Path("id") invite_id : Int ) : Completable
    }


}

