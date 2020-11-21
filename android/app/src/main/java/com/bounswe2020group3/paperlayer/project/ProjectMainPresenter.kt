package com.bounswe2020group3.paperlayer.project


import androidx.core.os.bundleOf
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import io.reactivex.disposables.CompositeDisposable


private const val TAG = "ProjectMainPresenter"

class ProjectMainPresenter: ProjectMainContract.Presenter {

    //Project Main Fragment view
    private lateinit var view: ProjectMainContract.View
    //Model for fetch data
    private var model: ProjectMainContract.Model = ProjectModel()
    //Disposable
    private var disposable = CompositeDisposable()

    //set project main fragment as a view of main project presenter
    override fun setView(view: ProjectMainContract.View) {
        this.view =view
    }

    override fun created() {
        this.view.writeLogMessage("i",TAG,"Project Main Presenter Created")
        // #FIX# Currently hardcoded
        fetchAllProjectsOfOwner(3)
    }

    override fun showMessage(message: String) {
        this.view.showToast(message)
    }

    override fun fetchAllProjectsOfOwner(ownerId: Int) {
        this.view.writeLogMessage("i",TAG, "Fetching all projects of owner $ownerId ...")
        val getProjectObservable = model.getAllProjectsOfOwner(ownerId).subscribe(
                { projectList ->
                    for (project in projectList){
                        this.view.addProjectCard(project.name,project.description,project.owner,project.id)
                        this.view.writeLogMessage("i",TAG,"Project Fetched")
                    }
                    this.view.writeLogMessage("i",TAG,"Fetching finished.")
                    this.view.submitProjectCardList()
                },
                { error ->
                    this.view.writeLogMessage("e",TAG,"Error in fetching all projects of owner $ownerId")
                }
        )
        disposable.add(getProjectObservable)
    }

    override fun onViewProjectButtonClicked(item: ProjectCard, position: Int) {
        //Navigation to project page, gives projectID as a bundle
        val bundle = bundleOf("projectID" to item.projectId )
        Navigation.findNavController(view.getLayout()).navigate(R.id.navigateToProjectFromProjectMainFragment,bundle)
    }

    override fun onEditProjectButtonClicked(item: ProjectCard, position: Int) {
        //#FIX# Update this after edit project page added
        //Navigation to project page, gives projectID as a bundle
        val bundle = bundleOf("projectID" to item.projectId )
        Navigation.findNavController(view.getLayout()).navigate(R.id.navigateToProjectFromProjectMainFragment,bundle)
    }

}