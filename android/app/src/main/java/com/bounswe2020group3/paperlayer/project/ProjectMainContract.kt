package com.bounswe2020group3.paperlayer.project

import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.Observable
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface ProjectMainContract {

    interface Presenter {
        fun setView(view: View)
        fun showMessage(message: String)
        fun created()
        fun onDestroyed()

        fun fetchAllProjectsOfOwner(ownerId: Int)
        fun onViewProjectButtonClicked(item: ProjectCard, position: Int)
        fun onEditProjectButtonClicked(item: ProjectCard, position: Int)
        fun onNewProjectButtonClicked()
    }

    interface View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun resetProjectCardList()
        fun submitProjectCardList()
        fun addProjectCard(projectName: String,projectBody: String,projectOwner: String,projectId: Int)
    }

    interface Model {
        //fun getProject(projectId: Int): Single<Project>
        fun getAllProjectsOfOwner(ownerId: Int): Observable<List<Project>>
    }

    interface ProjectService {
        @GET("/api/projects/{projectId}/")
        fun getProject(@Path("projectId") projectId: Int): Single<Project>

        @GET("/api/projects/")
        fun getAllProjectsOfOwner(@Query("owner__id") ownerId: Int): Observable<List<Project>>
    }

}