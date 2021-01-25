package com.bounswe2020group3.paperlayer.publication

import android.content.Context
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.ProjectCard
import com.bounswe2020group3.paperlayer.project.data.Publication
import com.bounswe2020group3.paperlayer.project.data.Tag
import io.reactivex.Observable
import retrofit2.Response
import retrofit2.http.*

interface       PublicationContract {

    interface Presenter: Mvp.Presenter<View> {
        fun setView(view: View)
        fun showMessage(message: String)

        fun fetchAllPublicationsOfOwner(ownerId: Int)
        fun onViewPublicationButtonClicked(item: ProjectCard, position: Int)
    }

    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun getMyContext(): Context
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun resetPublicationCardList()
        fun submitPublicationCardList()
        fun addPublicationCard(projectName: String, projectBody: String, projectOwner: String, tags: List<Tag>, projectId: Int)
    }

    interface Model {
        fun getAllPublicationsOfOwner(ownerId: Int): Observable<List<Publication>>
        fun addPublicationsOfOwner(authorId: String): Observable<Response<Void>>
    }

    interface PublicationService {
        @POST("/api/publications/add_publications/")
        fun addPublicationsOfOwner(@Header("Authorization") authorization: String, @Query("author_id") authorId: String): Observable<Response<Void>>

        @GET("/api/publications/")
        fun getAllPublicationsOfOwner(@Query("owner__id") ownerId: Int): Observable<List<Publication>>
    }

}