package com.bounswe2020group3.paperlayer.projectCreate

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject


class ProjectCreatePresenter @Inject constructor(private var model: ProjectCreateContract.Model) : BasePresenter<ProjectCreateContract.View>(), ProjectCreateContract.Presenter {

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
            view?.showToast("Error while creating project" + it)
        })
        disposable.add(createProjectObservable)

    }


}