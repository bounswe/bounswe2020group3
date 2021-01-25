package com.bounswe2020group3.paperlayer.dagger;


import com.bounswe2020group3.paperlayer.publication.PublicationContract;
import com.bounswe2020group3.paperlayer.publication.PublicationModel;
import com.bounswe2020group3.paperlayer.publication.PublicationPresenter;

import javax.inject.Singleton;

import dagger.Binds;
import dagger.Module;

@Module
abstract class PublicationModule{

    @Binds
    abstract fun bindPublicationPresenter(presenter: PublicationPresenter): PublicationContract.Presenter

    @Binds
    @Singleton
    abstract fun bindPublicationModel(model: PublicationModel): PublicationContract.Model

}