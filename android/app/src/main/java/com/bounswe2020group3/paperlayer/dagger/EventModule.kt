package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.event.EventDetailContract
import com.bounswe2020group3.paperlayer.event.EventDetailModel
import com.bounswe2020group3.paperlayer.event.EventDetailPresenter
import dagger.Binds
import dagger.Module

@Module
abstract class EventModule {

    @Binds
    abstract fun bindEventDetailPresenter(presenter: EventDetailPresenter): EventDetailContract.Presenter

    @Binds
    abstract fun bindEventDetailModel(model: EventDetailModel): EventDetailContract.Model
}