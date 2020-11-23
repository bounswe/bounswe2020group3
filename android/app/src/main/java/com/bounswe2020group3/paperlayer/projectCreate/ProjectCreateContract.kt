package com.bounswe2020group3.paperlayer.projectCreate

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView
import com.bounswe2020group3.paperlayer.project.ProjectMainContract
import io.reactivex.Single
import retrofit2.http.Body
import retrofit2.http.Header
import retrofit2.http.POST
import java.util.*

interface ProjectCreateContract {
    interface Presenter: BasePresenter {
        fun onViewCreated()
        fun createProject(projectCreateRequest: ProjectCreateRequest)
    }

    interface View: BaseView<Presenter> {
        fun showProgress(show: Boolean)
        fun showSuccess()
        fun displayTime(calendar: Calendar, selectedDate: Long): String
        fun showToast(message: String)
    }

    interface Model {
        fun createProject(projectCreateRequest: ProjectCreateRequest): Single<ProjectCreateResponse>
    }

    interface ProjectCreateService {
        @POST("/api/projects/")
        fun createProject(@Header("Authorization") authorization: String, @Body projectCreateRequest: ProjectCreateRequest): Single<ProjectCreateResponse>
    }
}