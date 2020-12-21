package com.bounswe2020group3.paperlayer.dagger


import com.bounswe2020group3.paperlayer.profile.list.UserListContract
import com.bounswe2020group3.paperlayer.profile.list.UserListPresenter
import com.bounswe2020group3.paperlayer.profile.user.UserContract
import com.bounswe2020group3.paperlayer.profile.user.UserPresenter
import dagger.Binds
import dagger.Module

@Module
abstract class UserModule {

    @Binds
    abstract fun bindUserListPresenter(presenter: UserListPresenter): UserListContract.Presenter

    @Binds
    abstract fun bindUserPresenter(presenter: UserPresenter): UserContract.Presenter
}