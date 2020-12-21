package com.bounswe2020group3.paperlayer.project


import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Retrofit
import javax.inject.Inject

class ProjectModel @Inject constructor(private var sessionManager: Session,retrofit: Retrofit):ProjectMainContract.Model,ProjectContract.Model{

    private var projectService: ProjectMainContract.ProjectService = retrofit.create(ProjectMainContract.ProjectService::class.java)

    //ProjectContract.Model
    //Get given project
    override fun getProject(projectId: Int): Single<Project> {
        return projectService.getProject(projectId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    //ProjectMainContract.Model
    //Get all projects of given owner
    override fun getAllProjectsOfOwner(ownerId: Int): Observable<List<ProjectShort>> {
        return projectService.getAllProjectsOfOwner(ownerId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
    //Get auth token
    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        return sessionManager.getToken()
    }

}