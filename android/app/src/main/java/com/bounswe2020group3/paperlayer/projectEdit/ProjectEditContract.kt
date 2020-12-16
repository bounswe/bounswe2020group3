package com.bounswe2020group3.paperlayer.projectEdit

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateRequest
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateResponse
import io.reactivex.Single
import retrofit2.http.*
import java.util.*


interface ProjectEditContract {

    interface Presenter: Mvp.Presenter<View> {
        fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest)
    }

    interface View: Mvp.View {
        fun showToast(message: String)
        fun displayTime(calendar: Calendar, selectedDate: Long): String
        fun showProgress(show: Boolean)
    }

    interface Model {
        fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest): Single<ProjectEditResponse>
    }

    interface ProjectEditService {

        @PATCH("/api/projects/{projectID}/")
        fun editProject(@Header("Authorization") authorization: String, @Path("projectID") projectID: Int, @Body projectEditRequest: ProjectEditRequest): Single<ProjectEditResponse>

    }

}