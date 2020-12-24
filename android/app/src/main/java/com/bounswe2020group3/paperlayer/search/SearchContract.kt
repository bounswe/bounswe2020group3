package com.bounswe2020group3.paperlayer.search

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import com.bounswe2020group3.paperlayer.search.data.User
import io.reactivex.Observable
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query


interface SearchContract {


    interface Presenter : Mvp.Presenter<View>{
        fun setView(view: View)
        fun showMessage(message: String)
        fun navigateToProject(projectID: Int)
        fun navigateToUser(userID: Int)
        fun navigateToEvent(eventID: Int)

        fun searchRequest(keyword:String)
        fun getAllProjects()
        fun getAllUsers()
        fun getAllEvents()
        fun onProjectClicked(item:SearchCard,position:Int)
        fun onUserClicked(item:SearchCard,position:Int)
        fun onEventClicked(item:SearchCard,position:Int)
    }

    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun resetSearchCardList()
        fun submitSearchCardList()
        fun addSearchCard(searchType: Int,titleIconType: Int,title:String,body:String,supportText:String,tags:List<String>,id:Int)
    }

    //FIX
    interface Model {
        fun searchProject(keyword: String): Single<List<Project>>
        fun getAllProjects(): Observable<List<ProjectShort>>
        fun getAllUsers(): Observable<List<User>>
        fun getAllEvents(): Observable<List<Event>>
    }

    interface SearchService {
        @GET("/api/search/{keyword}/")
        fun searchProject(@Path("keyword") keyword: String): Single<List<Project>>
        @GET("/api/projects/")
        fun getAllProjects(): Observable<List<ProjectShort>>
        @GET("/api/users/")
        fun getAllUsers(): Observable<List<User>>
        @GET("/api/events/")
        fun getAllEvents(): Observable<List<Event>>
    }

}