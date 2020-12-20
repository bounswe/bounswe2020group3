package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.home.*
import dagger.Binds
import dagger.Module
import javax.inject.Singleton


@Module
abstract class HomeModule {

    @Binds
    abstract fun bindEventPresenter(presenter: EventPresenter): HomeContract.EventPresenter

    @Binds
    abstract fun bindMilestonePresenter(presenter: MilestonePresenter): HomeContract.MileStonePresenter

    @Binds
    abstract fun bindRecentProjectsPresenter(presenter: RecentProjectsPresenter): HomeContract.RecentProjectsPresenter

    @Binds
    @Singleton
    abstract fun bindHomeModel(model: HomeModel): HomeContract.Model
}
