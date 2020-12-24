package com.bounswe2020group3.paperlayer.search

import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import com.bounswe2020group3.paperlayer.search.data.User
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Retrofit
import javax.inject.Inject

class SearchModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit):SearchContract.Model {

    private var searchService: SearchContract.SearchService = retrofit.create(
        SearchContract.SearchService::class.java)

    //SearchContract.Model
    //Search Project
    override fun searchProject(keyword:String): Single<List<Project>> {
        return searchService.searchProject(keyword)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    //Get all projects
    override fun getAllProjects(): Observable<List<ProjectShort>> {
        return searchService.getAllProjects()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
    //Get all users
    override fun getAllUsers(): Observable<List<User>> {
        return searchService.getAllUsers()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    //Get all events
    override fun getAllEvents(): Observable<List<Event>> {
        return searchService.getAllEvents()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }


}