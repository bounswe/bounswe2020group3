package com.bounswe2020group3.paperlayer.home


import com.bounswe2020group3.paperlayer.home.cards.EventCard
import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard
import com.bounswe2020group3.paperlayer.home.cards.ProjectUpdateCard
import com.bounswe2020group3.paperlayer.home.data.CollaborateRequest
import com.bounswe2020group3.paperlayer.home.data.CollaborationRequest
import com.bounswe2020group3.paperlayer.home.data.Event
import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.*

interface HomeContract {
    interface EventPresenter : Mvp.Presenter<EventView> {
        fun setView(eventView: HomeContract.EventView)
        fun showMessage(message: String)
        fun fetchEvents(ownerId : Int)
        fun subscribeAuthToken()
    }
    interface EventView: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun resetCardList()
        fun submitCardList()
        fun addCard(card : EventCard)

    }
    interface MileStoneView: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun resetCardList()
        fun submitCardList()
        fun addCard(card : MilestoneCard)

    }
    interface MileStonePresenter : Mvp.Presenter<MileStoneView> {
        fun setView(milestoneView: HomeContract.MileStoneView)
        fun showMessage(message: String)
        fun fetchMilestones(ownerId : Int)
        fun subscribeAuthToken()
    }
    interface RecentProjectsView: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun cardCheck(id : Int,position : Int)
        fun cardUncheck(id : Int,position : Int)
        fun resetCardList()
        fun submitCardList()
        fun addCard(card : ProjectUpdateCard)

    }
    interface RecentProjectsPresenter : Mvp.Presenter<RecentProjectsView> {
        fun setView(view: HomeContract.RecentProjectsView)
        fun showMessage(message: String)
        fun fetchProjects(ownerId : Int)
        fun subscribeAuthToken()
        fun OnInviteButtonClicked(Item : ProjectUpdateCard, position : Int)

    }


    interface HomeView: Mvp.View{


    }

    interface Model{
        fun getAllEvents(): Observable<List<Event>>?
        fun getAuthToken(): BehaviorSubject<AuthToken>
        fun getAllProjects(OwnerId:Int): Observable<List<ProjectShort>>
        fun collaborateRequest(request : CollaborateRequest) : Observable<CollaborationRequest>
        fun fetchRequests(userId:Int)   :   Observable<List<CollaborationRequest>>
        fun deleteRequest( collabId : Int ) : Completable
    }
    interface EventsService{
        @GET("/api/events/")
        fun getEvents(): Observable<List<Event>>
    }
    interface ProjectService {

        @GET("/api/projects/")
        fun getAllProjects(): Observable<List<ProjectShort>>


    }
    interface CollaborationRequestService{
        @POST("/api/collaboration_requests/")
        fun collaborationRequest(@Header("Authorization") authorization: String, @Body collaborate : CollaborateRequest) : Observable<CollaborationRequest>
        @GET("/api/collaboration_requests/")
        fun fetchRequests(@Query("from_user__id") userId: Int) : Observable<List<CollaborationRequest>>
        @DELETE("api/collaboration_requests/{id}/")
        fun deleteRequest(@Header("Authorization") authorization: String,@Path("id") collabId : Int ) : Completable
    }


}
