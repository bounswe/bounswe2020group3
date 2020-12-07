package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.ProfileModel
import com.bounswe2020group3.paperlayer.profile.ProfilePresenter
import com.bounswe2020group3.paperlayer.profile.edit.ProfileEditContract
import com.bounswe2020group3.paperlayer.profile.edit.ProfileEditPresenter
import com.bounswe2020group3.paperlayer.register.RegisterContract
import com.bounswe2020group3.paperlayer.register.RegisterModel
import com.bounswe2020group3.paperlayer.register.RegisterPresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class RegisterModule {

    @Binds
    abstract fun bindRegisterPresenter(presenter: RegisterPresenter): RegisterContract.Presenter

    @Binds
    @Singleton
    abstract fun bindRegisterModel(model: RegisterModel): RegisterContract.Model
}