package com.bounswe2020group3.paperlayer.dagger


import com.bounswe2020group3.paperlayer.profile.list.UserListContract
import com.bounswe2020group3.paperlayer.profile.list.UserListPresenter
import dagger.Binds
import dagger.Module

@Module
abstract class UserModule {

    @Binds
    abstract fun bindUserListPresenter(presenter: UserListPresenter): UserListContract.Presenter
}