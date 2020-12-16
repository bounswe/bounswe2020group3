package com.bounswe2020group3.paperlayer.projectEdit

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import timber.log.Timber
import javax.inject.Inject

class ProjectEditPresenter @Inject constructor(private var model: ProjectEditContract.Model) : BasePresenter<ProjectEditContract.View>(), ProjectEditContract.Presenter {
    private var disposable = CompositeDisposable()
    override fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest) {
        view?.showProgress(true)
        val editProjectObservable = model.editProject(projectID, projectEditRequest).subscribe({
            view?.showProgress(false)
            view?.showToast("SUCCESS EDIT PROJECT")
            disposable.clear()
        }, {
            view?.showProgress(false)
            disposable.clear()
            view?.showToast("Error while editing project")
        })
        disposable.add(editProjectObservable)
    }
}