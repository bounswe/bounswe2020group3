package com.bounswe2020group3.paperlayer.project


import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.home.data.CollaborateRequest
import com.bounswe2020group3.paperlayer.home.data.CollaborationRequest
import com.bounswe2020group3.paperlayer.project.data.File
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import com.bounswe2020group3.paperlayer.project.data.Publication
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Response
import retrofit2.Retrofit
import javax.inject.Inject

class ProjectModel @Inject constructor(private var sessionManager: Session,retrofit: Retrofit):ProjectsContract.Model,ProjectDetailContract.Model{

    private var projectService: ProjectsContract.ProjectService = retrofit.create(ProjectsContract.ProjectService::class.java)
    private var collabService: ProjectDetailContract.CollaborationRequestService = retrofit.create(ProjectDetailContract.CollaborationRequestService::class.java)
    private var fileService: ProjectDetailContract.FileService = retrofit.create(ProjectDetailContract.FileService::class.java)

    private val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"
    private val ownerID=sessionManager.getToken().value?.id ?:0
    //ProjectContract.Model
    //Get given project
    override fun getProject(projectId: Int): Single<Project> {
        return projectService.getProject(authToken, projectId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    //ProjectMainContract.Model
    //Get all projects of given owner
    override fun getAllProjectsOfOwner(ownerId: Int): Observable<List<ProjectShort>> {
        return projectService.getAllProjectsOfOwner(authToken, ownerId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
    //Get all publications of given owner
    override fun getAllPublicationsOfOwner(ownerId: Int): Observable<List<Publication>> {
        return projectService.getAllPublicationsOfOwner(ownerId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    //Add publications of given owner
    override fun addPublicationsOfOwner(authorId: String): Observable<Response<Void>>{
        return projectService.addPublicationsOfOwner(authToken,authorId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    //Get auth token
    override fun getAuthToken(): BehaviorSubject<AuthToken> {
        return sessionManager.getToken()
    }

    override fun collaborationRequest(request : CollaborateRequest) : Observable<CollaborationRequest> {

        return collabService.collaborationRequest(authToken,request)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun deleteRequest(collabId: Int): Completable {

        return collabService.deleteRequest(authToken,collabId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun fetchRequestofMine(projectId: Int) : Observable<List<CollaborationRequest>>{
        val ownerId = sessionManager.getToken().value?.id

        return collabService.fetchRequests(ownerId!!,projectId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun fetchFiles(projectId: Int): Observable<List<File>> {
        return fileService.fetchFiles(projectId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())    }
}