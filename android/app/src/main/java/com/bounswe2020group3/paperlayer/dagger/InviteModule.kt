package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.invite.InviteContract
import com.bounswe2020group3.paperlayer.invite.InviteModel
import com.bounswe2020group3.paperlayer.invite.InvitePresenter
import com.bounswe2020group3.paperlayer.project.*
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class InviteModule {



    @Binds
    abstract fun bindInvitePresenter(presenter: InvitePresenter): InviteContract.Presenter


    @Binds
    @Singleton
    abstract fun bindInviteModel(model: InviteModel): InviteContract.Model
}