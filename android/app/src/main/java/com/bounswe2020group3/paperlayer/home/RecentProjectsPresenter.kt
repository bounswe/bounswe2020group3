package com.bounswe2020group3.paperlayer.home

import android.view.View
import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard
import com.bounswe2020group3.paperlayer.home.cards.ProjectUpdateCard
import com.bounswe2020group3.paperlayer.home.data.CollaborateRequest
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject
private const val TAG = "RecentProjectsPresenter"

class RecentProjectsPresenter @Inject constructor(private var model: HomeContract.Model) : BasePresenter<HomeContract.RecentProjectsView>(), HomeContract.RecentProjectsPresenter  {

    private var disposable = CompositeDisposable()


    override fun bind(view: HomeContract.RecentProjectsView) {
        this.view?.writeLogMessage("i", TAG,"Event Presenter Created")

        subscribeAuthToken()
        super.bind(view)
    }

    override fun unbind() {
        disposable.clear()

        super.unbind()
    }
    override fun subscribeAuthToken() {
        val userProfileSub = model.getAuthToken().subscribe { token ->
            this.view?.writeLogMessage("i", TAG, "fetching auth")

            fetchProjects(token.id)
        }
        disposable.add(userProfileSub)
    }

    override fun setView(view: HomeContract.RecentProjectsView) {
        this.view =view
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun fetchProjects(ownerId: Int) {
        this.view?.writeLogMessage("i", TAG, "Fetching all projects of owner $ownerId ...")
        val getProjectObservable = model.getAllProjects(ownerId).subscribe(
                { projectList ->
                    for (project in projectList){
                        if(project.isPublic )
                            this.view?.addCard(ProjectUpdateCard(project.name,project.description,project.owner,project.id,"Project"))
                        this.view?.writeLogMessage("i", TAG,"Project Fetched + " )//+ project.project_type)
                    }
                    this.view?.writeLogMessage("i",TAG,"Fetching finished.")
                    this.view?.submitCardList()
                },
                { error ->
                    this.view?.writeLogMessage("e", TAG,"Error in fetching all projects of owner $ownerId $error")
                }
        )

        disposable.add(getProjectObservable)
    }

    override fun OnInviteButtonClicked(item: ProjectUpdateCard, position: Int) {

        val collaborateObservable = model.collaborateRequest(CollaborateRequest(item.projectId,"hello")).subscribe({

            view?.writeLogMessage("i", TAG, "request sent")
            view?.showToast("Request sent.")
            //view?.cardInviteCheck(item.id,position)
            disposable.clear()

        }, {
            view?.writeLogMessage("i", TAG, "Error while sending a request to project ${item.projectTitle} with the id ${item.projectId} " + it)

            view?.showToast("Error while sending a request to project ${item.projectTitle} with the id ${item.projectId} " + it)
            disposable.clear()

        })
        disposable.add(collaborateObservable)
    }
}