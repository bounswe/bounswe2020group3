package com.bounswe2020group3.paperlayer.projectEdit

import android.view.View
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.Single
import retrofit2.http.*
import java.util.*


interface ProjectEditContract {

    interface Presenter: Mvp.Presenter<View> {
        fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest)
        fun navigateToProjectDetail(projectID: Int?)
    }

    interface View: Mvp.View {
        fun showToast(message: String)
        fun displayTime(calendar: Calendar, selectedDate: Long): String
        fun showProgress(show: Boolean)
        fun showSuccess()
    }

    interface Model {
        fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest): Single<Project>
    }

    interface ProjectEditService {

        @PATCH("/api/projects/{projectID}/")
        fun editProject(@Header("Authorization") authorization: String, @Path("projectID") projectID: Int, @Body projectEditRequest: ProjectEditRequest): Single<Project>

    }

}