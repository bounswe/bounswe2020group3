package com.bounswe2020group3.paperlayer.home

import com.bounswe2020group3.paperlayer.home.data.Event
import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Retrofit
import javax.inject.Inject

class HomeModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit): HomeContract.Model {
    private var eventService: HomeContract.EventsService = retrofit.create(HomeContract.EventsService::class.java)
    private var projectService: HomeContract.ProjectService = retrofit.create(HomeContract.ProjectService::class.java)

    override fun getAllEvents(): Observable<List<Event>>? {
        return eventService.getEvents()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        return sessionManager.getToken()
    }

    override fun getallprojectsOfTheOwner(ownerId:Int): Observable<List<Project>> {
        return projectService.getAllProjectsOfOwner(ownerId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}