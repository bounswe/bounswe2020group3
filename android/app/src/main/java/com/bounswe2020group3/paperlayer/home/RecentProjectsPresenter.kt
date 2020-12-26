package com.bounswe2020group3.paperlayer.home

import android.view.View
import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard
import com.bounswe2020group3.paperlayer.home.cards.ProjectUpdateCard
import com.bounswe2020group3.paperlayer.home.data.CollaborateRequest
import com.bounswe2020group3.paperlayer.home.data.CollaborationRequest
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject
private const val TAG = "RecentProjectsPresenter"

class RecentProjectsPresenter @Inject constructor(private var model: HomeContract.Model) : BasePresenter<HomeContract.RecentProjectsView>(), HomeContract.RecentProjectsPresenter  {

    private var disposable = CompositeDisposable()
    private var requestSent : ArrayList<CollaborationRequest> = ArrayList()

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

                    val getRequestsObservable = model.fetchRequests(ownerId).subscribe(
                            { requests ->
                                var requested : ArrayList<Int> = ArrayList()
                                for(request in requests){
                                    requested.add(request.to_project)
                                    requestSent.add(request)
                                }
                                for (project in projectList) {
                                    if (project.isPublic)
                                        if(project.id in requested)
                                            this.view?.addCard(ProjectUpdateCard(project.name, project.description, project.owner, project.id, "Project",project.state,true))
                                        else
                                            this.view?.addCard(ProjectUpdateCard(project.name, project.description, project.owner, project.id, "Project",project.state,false))
                                    this.view?.writeLogMessage("i", TAG, "Project Fetched + ")//+ project.project_type)
                                }
                                this.view?.writeLogMessage("i", TAG, "Fetching finished.")
                                this.view?.submitCardList()
                            },
                            { error ->
                                this.view?.writeLogMessage("e", TAG, "Error in fetching all projects of owner $ownerId $error")
                            }
                    )
                },
                {error ->
                    this.view?.writeLogMessage("e", TAG, "Error in fetching all projects of owner $ownerId $error")
                })

        disposable.add(getProjectObservable)
    }

    override fun OnInviteButtonClicked(item: ProjectUpdateCard, position: Int) {
        if(!item.requestSent) {
            val collaborateObservable = model.collaborateRequest(CollaborateRequest(item.projectId, "hello")).subscribe({request->

                view?.writeLogMessage("i", TAG, "request sent")
                view?.showToast("Request sent.")
                view?.cardCheck(item.projectId,position)
                requestSent.add(request)
                view?.writeLogMessage("i",TAG,"request to project ${request.to_project} with the requestid ${request.id}")
                //view?.cardInviteCheck(item.id,position)
                disposable.clear()

            }, {
                view?.writeLogMessage("i", TAG, "Error while sending a request to project ${item.projectTitle} with the id ${item.projectId} " + it)

                view?.showToast("Error while sending a request to project ${item.projectTitle} with the id ${item.projectId} " + it)
                disposable.clear()

            })
            disposable.add(collaborateObservable)
        }
        else{
            var i = 0
            var index : Int  = 0
            while(i<requestSent.size)
            {
                if(requestSent[i].to_project == item.projectId) {
                    index = requestSent[i].id
                    break
                }
                i++
            }
            view?.writeLogMessage("i", TAG,"request withdrawal for $index sent")

            val uninviteUserObservable = model.deleteRequest(index).subscribe({
                view?.writeLogMessage("i", TAG,"request withdrawal successful")
                view?.cardUncheck(item.projectId,position)
                requestSent.removeAt(i)
                disposable.clear()
                //item.called = false
            },
                    {
                        view?.writeLogMessage("e", TAG,"request withdrawal unsuccessful $it")
                        disposable.clear()
                    })
            disposable.add(uninviteUserObservable)
        }
    }
}