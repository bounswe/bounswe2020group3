package com.bounswe2020group3.paperlayer.project

import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject

interface ProjectDetailContract {

    interface Presenter : Mvp.Presenter<View>{
        fun setView(view: View)
        fun showMessage(message: String)
        fun fetchProject(projectId: Int)
        fun setProject(project: Project)
        fun getProject(): Project?
        fun navigateToEditProject()
        fun subscribeAuthToken()
    }

    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)
        fun resetProjectUI()
        fun updateProjectUI(project:Project)

        fun resetMemberCardList()
        fun submitMemberCardList()
        fun addMemberCard(username: String, userId: Int)
        fun updateCurrentUser(ownerID:Int)
    }

    interface Model {
        fun getProject(projectId: Int): Single<Project>
        fun getAuthToken(): BehaviorSubject<AuthToken>
    }

}