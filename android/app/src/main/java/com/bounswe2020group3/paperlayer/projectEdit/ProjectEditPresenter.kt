package com.bounswe2020group3.paperlayer.projectEdit

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class ProjectEditPresenter @Inject constructor(private var model: ProjectEditContract.Model) : BasePresenter<ProjectEditContract.View>(), ProjectEditContract.Presenter {
    private var disposable = CompositeDisposable()
}