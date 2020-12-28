package com.bounswe2020group3.paperlayer.project

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.home.data.CollaborateRequest
import com.bounswe2020group3.paperlayer.home.data.CollaborationRequest
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.*

interface ProjectDetailContract {

    interface Presenter : Mvp.Presenter<View>{
        fun setView(view: View)
        fun showMessage(message: String)
        fun fetchProject(projectId: Int)
        fun setProject(project: Project)
        fun getProject(): Project?
        fun navigateToEditProject()
        fun subscribeAuthToken()
        fun OnClickCollab(projectId: Int,collabbed : Int)
        fun fetchRequestOfMine(projectId: Int)
    }

    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)
        fun resetProjectUI()
        fun updateProjectUI(project:Project)

        fun resetMemberCardList()
        fun submitMemberCardList()
        fun addMemberCard(username: String, userId: Int)
        fun updateCurrentUser(ownerID:Int)

        fun collabCheck(index : Int)
        fun collabUncheck()
    }

    interface Model {
        fun collaborationRequest(request : CollaborateRequest) : Observable<CollaborationRequest>
        fun deleteRequest(collabId: Int) : Completable
        fun fetchRequestofMine(projectId: Int): Observable<List<CollaborationRequest>>
        fun getProject(projectId: Int): Single<Project>
        fun getAuthToken(): BehaviorSubject<AuthToken>
    }
    interface CollaborationRequestService {
        @POST("/api/collaboration_requests/")
        fun collaborationRequest(@Header("Authorization") authorization: String, @Body collaborate: CollaborateRequest): Observable<CollaborationRequest>

        @GET("/api/collaboration_requests/")
        fun fetchRequests(@Query("from_user__id") userId: Int,@Query("to_project__id") projectId: Int) : Observable<List<CollaborationRequest>>
        @DELETE("api/collaboration_requests/{id}/")
        fun deleteRequest(@Header("Authorization") authorization: String,@Path("id") collabId : Int ) : Completable
    }
}