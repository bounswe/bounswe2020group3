package com.bounswe2020group3.paperlayer.dagger



import com.bounswe2020group3.paperlayer.project.*
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class ProjectModule{


    @Binds
    abstract fun bindProjectMainPresenter(presenter: ProjectMainPresenter): ProjectMainContract.Presenter

    @Binds
    abstract fun bindProjectPresenter(presenter: ProjectPresenter): ProjectContract.Presenter

    @Binds
    @Singleton
    abstract fun bindProjectMainModel(model: ProjectModel): ProjectMainContract.Model

    @Binds
    @Singleton
    abstract fun bindProjectModel(model: ProjectModel): ProjectContract.Model

}