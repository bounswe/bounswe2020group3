package com.bounswe2020group3.paperlayer.projectCreate

import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.util.TOKEN
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class ProjectCreateModel: ProjectCreateContract.Model {

    private var projectCreateService: ProjectCreateContract.ProjectCreateService = RetrofitProvider.instance.create(ProjectCreateContract.ProjectCreateService::class.java)
    override fun createProject(projectCreateRequest: ProjectCreateRequest): Single<ProjectCreateResponse> {
        return projectCreateService.createProject(TOKEN, projectCreateRequest)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}
