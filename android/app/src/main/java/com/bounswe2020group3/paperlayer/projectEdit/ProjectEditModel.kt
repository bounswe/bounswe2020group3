package com.bounswe2020group3.paperlayer.projectEdit

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

class ProjectEditModel @Inject constructor(private var sessionManager: Session): ProjectEditContract.Model {

    private var projectEditService: ProjectEditContract.ProjectEditService =
            RetrofitProvider.instance.create(ProjectEditContract.ProjectEditService::class.java)
    private val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"
    override fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest): Single<ProjectEditResponse> {
        return projectEditService.editProject(authToken, projectID, projectEditRequest)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
    override fun fetchEvents(): Observable<List<Event>> {
        return projectEditService.getEvents(authToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun fetchTags(): Observable<List<Tag>> {
        return projectEditService.getTags(authToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}