package com.bounswe2020group3.paperlayer.projectCreate

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.Tag
import io.reactivex.Observable
import io.reactivex.Single
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.Header
import retrofit2.http.POST
import java.util.Calendar

interface ProjectCreateContract {
    interface Presenter: Mvp.Presenter<View> {
        fun createProject(projectCreateRequest: ProjectCreateRequest)
        fun fetchEvents()
        fun fetchTags()
        fun getTagList(): List<Tag>
        fun getEventList(): List<Event>
    }

    interface View: Mvp.View {
        fun showProgress(show: Boolean)
        fun showSuccess()
        fun displayTime(calendar: Calendar, selectedDate: Long): String
        fun showToast(message: String)
        fun createEventSpinner()
        fun createTagSelectDialog()
    }

    interface Model {
        fun createProject(projectCreateRequest: ProjectCreateRequest): Single<ProjectCreateResponse>
        fun fetchEvents(): Observable<List<Event>>
        fun fetchTags(): Observable<List<Tag>>
    }

    interface ProjectCreateService {
        @POST("/api/projects/")
        fun postProject(@Header("Authorization") authorization: String, @Body projectCreateRequest: ProjectCreateRequest): Single<ProjectCreateResponse>

        @GET("/api/events/")
        fun getEvents(@Header("Authorization") authorization: String): Observable<List<Event>>

        @GET("/api/tags")
        fun getTags(@Header("Authorization") authorization: String): Observable<List<Tag>>
    }
}