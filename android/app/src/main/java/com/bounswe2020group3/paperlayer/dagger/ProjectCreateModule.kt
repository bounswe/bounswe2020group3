package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateContract
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateModel
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreatePresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class ProjectCreateModule {

    @Binds
    abstract fun bindProjectCreatePresenter(presenter: ProjectCreatePresenter): ProjectCreateContract.Presenter

    @Binds
    @Singleton
    abstract fun bindProjectCreateModel(model: ProjectCreateModel): ProjectCreateContract.Model
}