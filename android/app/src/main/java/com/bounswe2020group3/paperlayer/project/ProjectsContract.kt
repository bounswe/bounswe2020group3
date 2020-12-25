package com.bounswe2020group3.paperlayer.project

import com.bounswe2020group3.paperlayer.profile.data.data.AuthToken
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface       ProjectsContract {

    interface Presenter: Mvp.Presenter<View> {
        fun setView(view: View)
        fun showMessage(message: String)

        fun subscribeAuthToken()
        fun fetchAllProjectsOfOwner(ownerId: Int)
        fun onViewProjectButtonClicked(item: ProjectCard, position: Int)
        fun onEditProjectButtonClicked(item: ProjectCard, position: Int)
        fun onNewProjectButtonClicked()
    }

    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun resetProjectCardList()
        fun submitProjectCardList()
        fun addProjectCard(projectName: String,projectBody: String,projectOwner: String,projectId: Int,projectType: String)
    }

    interface Model {
        //fun getProject(projectId: Int): Single<Project>
        fun getAllProjectsOfOwner(ownerId: Int): Observable<List<ProjectShort>>
        fun getAuthToken(): BehaviorSubject<AuthToken>
    }

    interface ProjectService {
        @GET("/api/projects/{projectId}/")
        fun getProject(@Path("projectId") projectId: Int): Single<Project>

        @GET("/api/projects/")
        fun getAllProjectsOfOwner(@Query("owner__id") ownerId: Int): Observable<List<ProjectShort>>
    }

}