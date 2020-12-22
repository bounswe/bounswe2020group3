package com.bounswe2020group3.paperlayer.dagger



import com.bounswe2020group3.paperlayer.search.SearchContract
import com.bounswe2020group3.paperlayer.search.SearchModel
import com.bounswe2020group3.paperlayer.search.SearchPresenter
import dagger.Binds
import dagger.Module
import javax.inject.Singleton


@Module
abstract class SearchModule {
    @Binds
    abstract fun bindSearchPresenter(presenter: SearchPresenter): SearchContract.Presenter

    @Binds
    @Singleton
    abstract fun bindSearchModel(model: SearchModel): SearchContract.Model

}