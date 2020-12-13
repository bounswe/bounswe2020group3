package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.home.HomeContract
import com.bounswe2020group3.paperlayer.home.HomeModel
import com.bounswe2020group3.paperlayer.home.EventPresenter
import com.bounswe2020group3.paperlayer.home.MilestonePresenter
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
    @Singleton
    abstract fun bindHomeModel(model: HomeModel): HomeContract.Model
}
