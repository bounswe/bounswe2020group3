package com.bounswe2020group3.paperlayer.project


import androidx.core.os.bundleOf
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject


private const val TAG = "ProjectMainPresenter"

class ProjectMainPresenter @Inject constructor(private var model: ProjectsContract.Model) : BasePresenter<ProjectsContract.View>(),ProjectsContract.Presenter {

    //Disposable
    private var disposable = CompositeDisposable()

    override fun bind(view: ProjectsContract.View) {
        super.bind(view)
        this.view?.writeLogMessage("i",TAG,"Project Main Presenter Created")
        subscribeAuthToken()
    }

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    //set project main fragment as a view of main project presenter
    override fun setView(view: ProjectsContract.View) {
        this.view =view
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun subscribeAuthToken() {
        this.view?.writeLogMessage("i",TAG, "##1##")
        val userProfileSub = model.getAuthToken().subscribe { token ->
            fetchAllProjectsOfOwner(token.id)
        }
        disposable.add(userProfileSub)
    }

    override fun fetchAllProjectsOfOwner(ownerId: Int) {
        this.view?.writeLogMessage("i",TAG, "Fetching all projects of owner $ownerId ...")
        val getProjectObservable = model.getAllProjectsOfOwner(ownerId).subscribe(
                { projectList ->
                    for (project in projectList){
                        this.view?.addProjectCard(project.name,project.description,project.owner,project.id,"Project")
                        this.view?.writeLogMessage("i",TAG,"Project Fetched + " )//+ project.project_type)
                    }
                    this.view?.writeLogMessage("i",TAG,"Fetching finished.")
                    this.view?.submitProjectCardList()
                },
                { error ->
                    this.view?.writeLogMessage("e",TAG,"Error in fetching all projects of owner $ownerId $error")
                }
        )
        disposable.add(getProjectObservable)
    }

    override fun onViewProjectButtonClicked(item: ProjectCard, position: Int) {
        //Navigation to project page, gives projectID as a bundle
        val bundle = bundleOf("projectID" to item.projectId )
        view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectFromProjectMainFragment,bundle) }
    }

    override fun onEditProjectButtonClicked(item: ProjectCard, position: Int) {
        //#FIX# Update this after edit project page added
        //Navigation to project page, gives projectID as a bundle
        val bundle = bundleOf("projectID" to item.projectId )
        view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectFromProjectMainFragment,bundle) }
    }

    override fun onNewProjectButtonClicked() {
        view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectCreateFromProjectMainFragment) }
    }

}