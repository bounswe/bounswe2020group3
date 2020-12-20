package com.bounswe2020group3.paperlayer.projectEdit

import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import javax.inject.Inject

class ProjectEditModel @Inject constructor(private var sessionManager: Session): ProjectEditContract.Model {

    private var projectEditService: ProjectEditContract.ProjectEditService =
            RetrofitProvider.instance.create(ProjectEditContract.ProjectEditService::class.java)

    override fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest): Single<ProjectEditResponse> {
        val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"

        return projectEditService.editProject(authToken, projectID, projectEditRequest)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}