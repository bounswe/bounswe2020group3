package com.bounswe2020group3.paperlayer.project

import android.view.View
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

private const val TAG = "ProjectPresenter"

class ProjectPresenter  @Inject constructor(private var model: ProjectContract.Model) : BasePresenter<ProjectContract.View>(),ProjectContract.Presenter {

    //Disposable
    private var disposable = CompositeDisposable()

    override fun setView(view: ProjectContract.View) {
        this.view =view
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun bind(view: ProjectContract.View) {
        super.bind(view)
        this.view?.writeLogMessage("i",TAG,"Project Presenter Created")
        this.view?.resetProjectUI()
    }

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    //Fetch project and update ui
    override fun fetchProject(projectId: Int) {
        this.view?.writeLogMessage("i",TAG,"Fetching the project...")
        val getProjectObservable = model.getProject(projectId).subscribe(
                { project ->
                    this.view?.writeLogMessage("i",TAG,"Fetching Successful.")
                    this.view?.updateProjectUI(project)
                },
                { error ->
                    this.view?.writeLogMessage("e",TAG,"Error in fetching project")
                }
        )
        disposable.add(getProjectObservable)
    }

}