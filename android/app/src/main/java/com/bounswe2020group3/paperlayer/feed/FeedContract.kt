package com.bounswe2020group3.paperlayer.feed

import com.bounswe2020group3.paperlayer.feed.data.Feed
import com.bounswe2020group3.paperlayer.feed.data.FeedResponse
import com.bounswe2020group3.paperlayer.mvp.Mvp
import io.reactivex.Observable
import retrofit2.http.GET
import retrofit2.http.Header

interface FeedContract {

    interface Presenter: Mvp.Presenter<View> {
        fun fetchFeedTimeline()
    }

    interface View: Mvp.View {
        fun showProgress(show: Boolean)
        fun showToast(message: String)
        fun setupRecyclerViewItems(feedList: List<Feed>)
    }

    interface Model {
        fun getFeedTimeline(): Observable<FeedResponse>
    }

    interface FeedService {
        @GET("/api/feeds/timeline/")
        fun getFeedTimeline(@Header("Authorization") authorization: String): Observable<FeedResponse>
    }
}