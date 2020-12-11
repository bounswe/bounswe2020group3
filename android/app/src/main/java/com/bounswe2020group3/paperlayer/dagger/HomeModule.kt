package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.home.HomeContract
import com.bounswe2020group3.paperlayer.home.HomeModel
import com.bounswe2020group3.paperlayer.home.HomePresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton


@Module
abstract class HomeModule {

    @Binds
    abstract fun bindHomePresenter(presenter: HomePresenter): HomeContract.Presenter


    @Binds
    @Singleton
    abstract fun bindHomeModel(model: HomeModel): HomeContract.Model
}
