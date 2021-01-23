package com.bounswe2020group3.paperlayer.search

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import com.bounswe2020group3.paperlayer.project.data.Tag
import com.bounswe2020group3.paperlayer.search.data.Search
import com.bounswe2020group3.paperlayer.search.data.SearchResponse
import com.bounswe2020group3.paperlayer.search.data.User
import io.reactivex.Observable
import io.reactivex.Single
import retrofit2.http.*


interface SearchContract {


    interface Presenter : Mvp.Presenter<View>{
        fun setView(view: View)
        fun showMessage(message: String)
        fun navigateToProject(projectID: Int)
        fun navigateToUser(userID: Int)
        fun navigateToEvent(eventID: Int)

        fun searchRequest(searchFilter:Search)
        fun getTags()
        fun onProjectClicked(item:SearchCard,position:Int)
        fun onUserClicked(item:SearchCard,position:Int)
        fun onEventClicked(item:SearchCard,position:Int)
    }

    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)
        fun showLoading()
        fun hideLoading()

        fun setTags(tags:List<Tag>)
        fun resetSearchCardList()
        fun submitSearchCardList()
        fun addSearchCard(searchType: Int,titleIconType: Int,title:String,body:String,supportText:String,tags:List<Tag>,id:Int)
    }

    interface AdvancedSearchView: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)
    }

    interface Model {
        fun searchRequest(searchFilter: Search): Single<SearchResponse>
        fun getTags(): Observable<List<Tag>>
    }

    interface SearchService {
        @POST("/api/search/")
        fun searchRequest(@Body searchFilter: Search): Single<SearchResponse>
        @GET("/api/tags/")
        fun getTags(): Observable<List<Tag>>
    }

}