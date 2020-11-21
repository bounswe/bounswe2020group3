package com.bounswe2020group3.paperlayer.project

import io.reactivex.disposables.CompositeDisposable

private const val TAG = "ProjectPresenter"

class ProjectPresenter : ProjectContract.Presenter {

    //Project Fragment view
    private lateinit var view: ProjectContract.View
    //Model for fetch data
    private var model: ProjectContract.Model = ProjectModel()
    //Disposable
    private var disposable = CompositeDisposable()

    override fun setView(view: ProjectContract.View) {
        this.view =view
    }

    override fun showMessage(message: String) {
        this.view.showToast(message)
    }

    override fun created() {
        this.view.writeLogMessage("i",TAG,"Project Presenter Created")
        this.view.resetProjectUI()
    }

    //Fetch project and update ui
    override fun fetchProject(projectId: Int) {
        this.view.writeLogMessage("i",TAG,"Fetching the project...")
        val getProjectObservable = model.getProject(projectId).subscribe(
                { project ->
                    this.view.writeLogMessage("i",TAG,"Fetching Successful.")
                    this.view.updateProjectUI(project)
                },
                { error ->
                    this.view.writeLogMessage("e",TAG,"Error in fetching project")
                }
        )
        disposable.add(getProjectObservable)
    }

}