package com.bounswe2020group3.paperlayer.feed

import com.bounswe2020group3.paperlayer.feed.data.FeedResponse
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import javax.inject.Inject

class FeedModel @Inject constructor(sessionManager: Session): FeedContract.Model {
    private var feedService: FeedContract.FeedService = RetrofitProvider.instance.create(
        FeedContract.FeedService::class.java)
    private val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"
    override fun getFeedTimeline(): Observable<FeedResponse> {
        return feedService.getFeedTimeline(authToken)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }
}