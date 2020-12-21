package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.projectEdit.ProjectEditContract
import com.bounswe2020group3.paperlayer.projectEdit.ProjectEditModel
import com.bounswe2020group3.paperlayer.projectEdit.ProjectEditPresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class ProjectEditModule {

    @Binds
    abstract fun bindProjectCreatePresenter(presenter: ProjectEditPresenter): ProjectEditContract.Presenter

    @Binds
    @Singleton
    abstract fun bindProjectCreateModel(model: ProjectEditModel): ProjectEditContract.Model
}