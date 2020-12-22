package com.bounswe2020group3.paperlayer.projectCreate

import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import javax.inject.Inject

class ProjectCreateModel @Inject constructor(private var sessionManager: Session): ProjectCreateContract.Model {

    private var projectCreateService: ProjectCreateContract.ProjectCreateService = RetrofitProvider.instance.create(ProjectCreateContract.ProjectCreateService::class.java)
    override fun createProject(projectCreateRequest: ProjectCreateRequest): Single<Project> {
        val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"
        return projectCreateService.createProject(authToken, projectCreateRequest)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}
