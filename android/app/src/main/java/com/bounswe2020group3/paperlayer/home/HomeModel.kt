package com.bounswe2020group3.paperlayer.home

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.home.data.*
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Retrofit
import javax.inject.Inject

class HomeModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit): HomeContract.Model {
    private var eventService: HomeContract.EventsService = retrofit.create(HomeContract.EventsService::class.java)
    private var projectService: HomeContract.ProjectService = retrofit.create(HomeContract.ProjectService::class.java)
    private var collaborationService : HomeContract.CollaborationRequestService  = retrofit.create(HomeContract.CollaborationRequestService::class.java)
    private var milestonesService : HomeContract.MilestonesService = retrofit.create(HomeContract.MilestonesService::class.java)
    private val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"
    override fun getAllEvents(): Observable<List<Event>>? {
        return eventService.getEvents()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getNotifications(): Observable<NotificationResponse> {
        return eventService.getNotifications(authToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getUnreadNotificationCount(): Observable<NotificationUnreadCountResponse> {
        return eventService.getUnreadNotificationCount(authToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        return sessionManager.getToken()
    }

    override fun getAllProjects(ownerId:Int): Observable<List<ProjectShort>> {
        return projectService.getAllProjects()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun collaborateRequest(request : CollaborateRequest) : Observable<CollaborationRequest> {
        return collaborationService.collaborationRequest(authToken, request)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun fetchRequests(userId: Int): Observable<List<CollaborationRequest>> {
        return collaborationService.fetchRequests(userId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun deleteRequest(collabId: Int): Completable {
        return collaborationService.deleteRequest(authToken,collabId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())    }

    override fun getMilestones() : Observable<MilestoneListWrapper> {
        return milestonesService.getMilestones(authToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getRecommendedProjects(userId: Int): Observable<List<Project>> {
        return projectService.getRecommendedProjects(userId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}