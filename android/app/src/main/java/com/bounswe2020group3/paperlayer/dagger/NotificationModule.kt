package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.notifications.NotificationContract
import com.bounswe2020group3.paperlayer.notifications.NotificationModel
import com.bounswe2020group3.paperlayer.notifications.NotificationPresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class NotificationModule {

    @Binds
    abstract fun bindNotificationPresenter(presenter: NotificationPresenter): NotificationContract.Presenter

    @Binds
    @Singleton
    abstract fun bindNotificationModel(model: NotificationModel): NotificationContract.Model
}