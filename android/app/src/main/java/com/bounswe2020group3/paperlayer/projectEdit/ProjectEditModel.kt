package com.bounswe2020group3.paperlayer.projectEdit

import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateContract
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateRequest
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateResponse
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import javax.inject.Inject

class ProjectEditModel @Inject constructor(private var sessionManager: Session): ProjectEditContract.Model {

    private var projectEditService: ProjectEditContract.ProjectEditService = RetrofitProvider.instance.create(ProjectEditContract.ProjectEditService::class.java)
    override fun createProject(projectEditRequest: ProjectEditRequest): Single<ProjectEditResponse> {
        TODO("Will implement later")
    }

}