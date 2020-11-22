package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.ProfileModel
import com.bounswe2020group3.paperlayer.profile.ProfilePresenter
import com.bounswe2020group3.paperlayer.profile.edit.ProfileEditContract
import com.bounswe2020group3.paperlayer.profile.edit.ProfileEditPresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class ProfileModule {

    @Binds
    abstract fun bindProfilePresenter(presenter: ProfilePresenter): ProfileContract.Presenter

    @Binds
    abstract fun bindProfileEditPresenter(presenter: ProfileEditPresenter): ProfileEditContract.Presenter

    @Binds
    @Singleton
    abstract fun bindProfileModel(model: ProfileModel): ProfileContract.Model
}