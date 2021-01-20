package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.invite.*
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class InviteModule {



    @Binds
    abstract fun bindInvitePresenter(presenter: InvitePresenter): InviteContract.Presenter

    @Binds
    abstract fun bindManageInvitesPresenter(presenter: ManageInvitesPresenter): ManageInvitesContract.Presenter
    @Binds
    @Singleton
    abstract fun bindInviteModel(model: InviteModel): InviteContract.Model
}