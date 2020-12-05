package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.project.ProjectCard
import com.bounswe2020group3.paperlayer.login.LoginContract
import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query
interface InviteContract {
    interface Presenter: Mvp.Presenter<View> {
        fun setView(view: View)
        fun showMessage(message: String)

        fun subscribeAuthToken()
        fun fetchAllUsers(ownerId: Int)

    }

    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun resetUserCardlist()
        fun submitUserCardList()
        fun addUserCard(name: String,expertise: String,later: String,UserId: Int)
    }

    interface Model {
        //fun getProject(projectId: Int): Single<Project>
        fun getAllUsers(ownerId: Int): Observable<List<Project>>
        fun getAuthToken(): BehaviorSubject<AuthToken>
    }

    interface UserService {
        @GET("/api/projects/{projectId}/")
        fun getProject(@Path("projectId") projectId: Int): Single<Project>

        @GET("/api/projects/")
        fun getUsers(@Query("owner__id") ownerId: Int): Observable<List<Project>>
    }

}

