package com.bounswe2020group3.paperlayer.projectEdit

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Tag
import io.reactivex.Observable
import io.reactivex.Single
import retrofit2.http.*
import java.util.*
import kotlin.collections.ArrayList


interface ProjectEditContract {

    interface Presenter: Mvp.Presenter<View> {
        fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest)
        fun navigateToProjectDetail(projectID: Int?)
        fun fetchEvents()
        fun fetchTags()
        fun getTagList(): List<Tag>
        fun getEventList(): List<Event>
        fun getCurrentTagIndex(currentTagList: List<Tag>?): ArrayList<Int>
    }

    interface View: Mvp.View {
        fun showToast(message: String)
        fun displayTime(calendar: Calendar, selectedDate: Long): String
        fun showProgress(show: Boolean)
        fun showSuccess()
        fun createEventSpinner()
        fun createTagSelectDialog()
    }

    interface Model {
        fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest): Single<ProjectEditResponse>
        fun fetchEvents(): Observable<List<Event>>
        fun fetchTags(): Observable<List<Tag>>
    }

    interface ProjectEditService {

        @PATCH("/api/projects/{projectID}/")
        fun editProject(@Header("Authorization") authorization: String, @Path("projectID") projectID: Int, @Body projectEditRequest: ProjectEditRequest): Single<ProjectEditResponse>

        @GET("/api/events/")
        fun getEvents(@Header("Authorization") authorization: String): Observable<List<Event>>

        @GET("/api/tags")
        fun getTags(@Header("Authorization") authorization: String): Observable<List<Tag>>

    }

}