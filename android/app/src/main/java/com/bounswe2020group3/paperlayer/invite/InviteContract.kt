package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.project.ProjectCard
import com.bounswe2020group3.paperlayer.login.LoginContract
import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.profile.data.User
import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.GET
import retrofit2.http.POST
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
        fun addUserCard(username: String,name : String,expertise: String,photoURL: String)
    }

    interface Model {
        //fun getProject(projectId: Int): Single<Project>
        fun getAllUsers(): Observable<List<User>>?
        fun getAuthToken(): BehaviorSubject<AuthToken>
    }

    interface UserService {
        @POST("/api/projects/{projectId}/")
        fun inviteUsers(@Path("projectId") projectId: Int): Observable<List<User>>


        @GET("/api/users/")
        fun getUsers(): Observable<List<User>>
    }

}

