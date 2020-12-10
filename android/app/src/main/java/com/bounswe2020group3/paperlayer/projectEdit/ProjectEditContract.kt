package com.bounswe2020group3.paperlayer.projectEdit

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateRequest
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateResponse
import io.reactivex.Single


interface ProjectEditContract {

    interface Presenter: Mvp.Presenter<View> {

    }

    interface View: Mvp.View {
        fun showToast(message: String)
    }

    interface Model {
        fun createProject(projectEditRequest: ProjectEditRequest): Single<ProjectEditResponse>
    }

    interface ProjectEditService {

    }

}