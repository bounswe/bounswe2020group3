package com.bounswe2020group3.paperlayer.projectCreate

import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.Tag
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import javax.inject.Inject

class ProjectCreateModel @Inject constructor(sessionManager: Session): ProjectCreateContract.Model {

    private val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"
    private var projectCreateService: ProjectCreateContract.ProjectCreateService = RetrofitProvider.instance.create(ProjectCreateContract.ProjectCreateService::class.java)
    override fun createProject(projectCreateRequest: ProjectCreateRequest): Single<ProjectCreateResponse> {
        return projectCreateService.postProject(authToken, projectCreateRequest)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun fetchEvents(): Observable<List<Event>> {
        return projectCreateService.getEvents(authToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun fetchTags(): Observable<List<Tag>> {
        return projectCreateService.getTags(authToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}
