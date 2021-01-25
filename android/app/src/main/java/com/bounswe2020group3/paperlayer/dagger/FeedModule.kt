package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.feed.FeedContract
import com.bounswe2020group3.paperlayer.feed.FeedModel
import com.bounswe2020group3.paperlayer.feed.FeedPresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class FeedModule {

    @Binds
    abstract fun bindFeedPresenter(presenter: FeedPresenter): FeedContract.Presenter

    @Binds
    @Singleton
    abstract fun bindFeedModel(model: FeedModel): FeedContract.Model
}