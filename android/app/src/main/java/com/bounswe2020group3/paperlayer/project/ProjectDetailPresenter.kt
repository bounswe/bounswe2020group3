package com.bounswe2020group3.paperlayer.project

import android.os.Bundle
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.project.data.Project
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

private const val TAG = "ProjectPresenter"

class ProjectPresenter  @Inject constructor(private var model: ProjectDetailContract.Model) : BasePresenter<ProjectDetailContract.View>(),ProjectDetailContract.Presenter {

    //Disposable
    private var disposable = CompositeDisposable()
    private var project: Project? = null

    override fun setView(view: ProjectDetailContract.View) {
        this.view =view
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun bind(view: ProjectDetailContract.View) {
        super.bind(view)
        this.view?.writeLogMessage("i",TAG,"Project Presenter Created")
        this.view?.resetProjectUI()
    }

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun setProject(project: Project){
        this.project = project
    }

    override fun getProject(): Project? {
        if (project == null) return null
        return project
    }

    //Fetch project and update ui
    override fun fetchProject(projectId: Int) {
        this.view?.writeLogMessage("i",TAG,"Fetching the project...")
        val getProjectObservable = model.getProject(projectId).subscribe(
                { project ->
                    this.view?.writeLogMessage("i",TAG,"Fetching Successful.")
                    this.view?.updateProjectUI(project)
                    setProject(project)
                },
                { error ->
                    this.view?.writeLogMessage("e",TAG,"Error in fetching project")
                }
        )
        disposable.add(getProjectObservable)
    }

    override fun navigateToEditProject() {
        val bundle = Bundle()
        bundle.putParcelable("PROJECT", getProject())
        view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectEditFromProjectFragment, bundle) }
    }

}