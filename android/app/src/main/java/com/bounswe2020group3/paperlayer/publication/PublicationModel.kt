package com.bounswe2020group3.paperlayer.publication

import com.bounswe2020group3.paperlayer.project.data.Publication
import com.bounswe2020group3.paperlayer.util.Session

import io.reactivex.Observable

import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

import retrofit2.Response
import retrofit2.Retrofit
import javax.inject.Inject

class PublicationModel @Inject constructor(private var sessionManager: Session,retrofit: Retrofit):PublicationContract.Model{

    private var publicationService: PublicationContract.PublicationService = retrofit.create(PublicationContract.PublicationService::class.java)

    private val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"

    //Get all publications of given owner
    override fun getAllPublicationsOfOwner(ownerId: Int): Observable<List<Publication>> {
        return publicationService.getAllPublicationsOfOwner(ownerId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    //Add publications of given owner
    override fun addPublicationsOfOwner(authorId: String): Observable<Response<Void>> {
        return publicationService.addPublicationsOfOwner(authToken,authorId)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

}