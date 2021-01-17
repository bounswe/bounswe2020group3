package com.bounswe2020group3.paperlayer.dagger



import com.bounswe2020group3.paperlayer.project.*
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class ProjectModule{


    @Binds
    abstract fun bindProjectMainPresenter(presenter: ProjectMainPresenter): ProjectsContract.Presenter

    @Binds
    abstract fun bindProjectPresenter(presenter: ProjectPresenter): ProjectDetailContract.Presenter

    @Binds
    @Singleton
    abstract fun bindProjectMainModel(model: ProjectModel): ProjectsContract.Model

    @Binds
    @Singleton
    abstract fun bindProjectModel(model: ProjectModel): ProjectDetailContract.Model

}