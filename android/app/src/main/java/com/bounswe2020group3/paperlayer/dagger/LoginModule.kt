package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.login.LoginContract
import com.bounswe2020group3.paperlayer.login.LoginModel
import com.bounswe2020group3.paperlayer.login.LoginPresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class LoginModule {

    @Binds
    abstract fun bindLoginPresenter(presenter: LoginPresenter): LoginContract.Presenter

    @Binds
    @Singleton
    abstract fun bindLoginModel(model: LoginModel): LoginContract.Model
}