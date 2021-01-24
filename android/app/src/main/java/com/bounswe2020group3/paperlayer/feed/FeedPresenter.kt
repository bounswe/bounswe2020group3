package com.bounswe2020group3.paperlayer.feed

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class FeedPresenter @Inject constructor(private var model: FeedContract.Model): BasePresenter<FeedContract.View>(), FeedContract.Presenter {
    private var disposable = CompositeDisposable()

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }
    override fun fetchFeedTimeline() {
        view?.showProgress(true)
        val feedTimelineObservable = model.getFeedTimeline().subscribe({
            it.feedList?.let { feedList -> view?.setupRecyclerViewItems(feedList) }
            view?.showProgress(false)
        }, {
            view?.showToast("ERROR FEED REQ")
            view?.showProgress(false)
        })
        disposable.add(feedTimelineObservable)
    }
}