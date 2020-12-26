package com.bounswe2020group3.paperlayer.search

import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.project.data.ProjectShort
import com.bounswe2020group3.paperlayer.search.data.Search
import com.bounswe2020group3.paperlayer.search.data.SearchResponse
import com.bounswe2020group3.paperlayer.search.data.User
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Retrofit
import javax.inject.Inject

class SearchModel @Inject constructor(private var sessionManager: Session, retrofit: Retrofit):SearchContract.Model {

    private var searchService: SearchContract.SearchService = retrofit.create(
        SearchContract.SearchService::class.java)

    //SearchContract.Model
    //Search Request
    override fun searchRequest(searchFilter: Search): Single<SearchResponse> {
        return searchService.searchRequest(searchFilter)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

}