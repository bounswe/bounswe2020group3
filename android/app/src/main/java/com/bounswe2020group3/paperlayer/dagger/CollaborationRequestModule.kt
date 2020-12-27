package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.collaborationRequests.CollabContract
import com.bounswe2020group3.paperlayer.collaborationRequests.CollabModel
import com.bounswe2020group3.paperlayer.collaborationRequests.CollabPresenter
import dagger.Binds
import dagger.Module

@Module
abstract class CollaborationRequestModule {

    @Binds
    abstract fun bindEventDetailPresenter(presenter: CollabPresenter): CollabContract.CollabPresenter

    @Binds
    abstract fun bindEventDetailModel(model: CollabModel): CollabContract.Model
}