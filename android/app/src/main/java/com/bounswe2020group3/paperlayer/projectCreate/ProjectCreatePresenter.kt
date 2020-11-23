package com.bounswe2020group3.paperlayer.projectCreate

import io.reactivex.disposables.CompositeDisposable


class ProjectCreatePresenter(view: ProjectCreateContract.View) : ProjectCreateContract.Presenter {

    private var view: ProjectCreateContract.View? = view
    private val model: ProjectCreateContract.Model = ProjectCreateModel()
    private var disposable = CompositeDisposable()
    override fun onViewCreated() {

    }

    override fun createProject(projectCreateRequest: ProjectCreateRequest) {
        view?.showProgress(true)
        val createProjectObservable = model.createProject(projectCreateRequest).subscribe({
            view?.showSuccess()
            disposable.clear()
        }, {
            view?.showProgress(false)
            disposable.clear()
            view?.showToast("Error while creating project")
        })
        disposable.add(createProjectObservable)

    }

    override fun onDestroy() {
        this.view = null
        disposable.dispose()
    }


}