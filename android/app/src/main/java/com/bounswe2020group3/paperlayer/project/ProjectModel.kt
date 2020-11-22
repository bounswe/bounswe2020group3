package com.bounswe2020group3.paperlayer.project

import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class ProjectModel:ProjectMainContract.Model,ProjectContract.Model{

    private var projectService: ProjectMainContract.ProjectService = RetrofitProvider.instance.create(ProjectMainContract.ProjectService::class.java)

    //Get given project
    override fun getProject(projectId: Int): Single<Project> {
        return projectService.getProject(projectId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getAllProjectsOfOwner(ownerId: Int): Observable<List<Project>> {
        return projectService.getAllProjectsOfOwner(ownerId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())

    }


}