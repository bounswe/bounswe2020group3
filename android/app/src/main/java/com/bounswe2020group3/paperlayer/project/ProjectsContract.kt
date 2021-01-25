package com.bounswe2020group3.paperlayer.project

import android.content.Context
import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import com.bounswe2020group3.paperlayer.project.data.Publication
import com.bounswe2020group3.paperlayer.project.data.Tag
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.Response
import retrofit2.http.*

interface       ProjectsContract {

    interface Presenter: Mvp.Presenter<View> {
        fun setView(view: View)
        fun showMessage(message: String)

        fun subscribeAuthToken()
        fun fetchAllProjectsOfUser(userId: Int)
        fun fetchAllPublicationsOfOwner(ownerId: Int)
        fun connectScholarPublications(authorId: String)
        fun onViewProjectButtonClicked(item: ProjectCard, position: Int)
        fun onViewPublicationButtonClicked(item: ProjectCard, position: Int)
        fun onEditProjectButtonClicked(item: ProjectCard, position: Int)
        fun onNewProjectButtonClicked()
    }

    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun getMyContext(): Context
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun showPublicationAdd()
        fun hidePublicationAdd()

        fun resetProjectCardList()
        fun submitProjectCardList()
        fun addProjectCard(projectName: String, projectBody: String, projectOwner: String, projectId: Int, tags: List<Tag>, projectType: String)

        fun resetPublicationCardList()
        fun submitPublicationCardList()
        fun addPublicationCard(projectName: String,projectBody: String,projectOwner: String,tags: List<Tag>,projectId: Int)
    }

    interface Model {
        //fun getProject(projectId: Int): Single<Project>
        fun getAllProjectsOfOwner(ownerId: Int): Observable<List<ProjectShort>>
        fun getAllProjectsOfMember(userId: Int): Observable<List<ProjectShort>>
        fun getAllPublicationsOfOwner(ownerId: Int): Observable<List<Publication>>
        fun getAuthToken(): BehaviorSubject<AuthToken>
        fun addPublicationsOfOwner(authorId: String): Observable<Response<Void>>
    }

    interface ProjectService {
        @GET("/api/projects/{projectId}/")
        fun getProject(@Header("Authorization") authorization: String, @Path("projectId") projectId: Int): Single<Project>

        @GET("/api/projects/")
        fun getAllProjectsOfOwner(@Header("Authorization") authorization: String, @Query("owner__id") ownerId: Int): Observable<List<ProjectShort>>

        @GET("/api/projects/")
        fun getAllProjectsOfMember(@Header("Authorization") authorization: String, @Query("members__id") userId: Int): Observable<List<ProjectShort>>

        @POST("/api/publications/add_publications/")
        fun addPublicationsOfOwner(@Header("Authorization") authorization: String, @Query("author_id") authorId: String): Observable<Response<Void>>

        @GET("/api/publications/")
        fun getAllPublicationsOfOwner(@Query("owner__id") ownerId: Int): Observable<List<Publication>>
    }

}