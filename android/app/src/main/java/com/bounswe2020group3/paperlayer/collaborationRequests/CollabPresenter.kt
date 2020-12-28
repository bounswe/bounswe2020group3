package com.bounswe2020group3.paperlayer.collaborationRequests

import android.widget.TabHost
import com.bounswe2020group3.paperlayer.home.HomeContract
import com.bounswe2020group3.paperlayer.mvp.BasePresenter

import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

private const val TAG = "CollabPresenter"

class CollabPresenter  @Inject constructor(private var model: CollabContract.Model) : BasePresenter<CollabContract.CollabView>(), CollabContract.CollabPresenter  {
    private var disposable = CompositeDisposable()
    private var projectId : Int = -1

    override fun bind(view: CollabContract.CollabView) {
        this.view?.writeLogMessage("i", TAG,"Event Presenter Created")
        projectId = view.projectId

        subscribeAuthToken()
        super.bind(view)
    }

    override fun unbind() {
        disposable.clear()

        super.unbind()
    }

    override fun setView(eventView: HomeContract.EventView) {
        this.view =view
        projectId = view?.projectId!!
        view?.writeLogMessage("i",TAG,"$projectId 's reqs")


    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun fetchRequests(ownerId: Int) {
        val requestsObservable = model.fetchRequests(projectId).subscribe(
                { requests ->
                    view?.writeLogMessage("i",TAG,"${requests.size} reqs has been fetched for the project $projectId")
                    for(req in requests){
                        val  userObservable = model.getUser(req.from_user.toInt()).subscribe(
                                {user ->
                                    var fullname = "" + user.profile[0].name + user.profile[0].lastName
                                    var photoURL = "" + user.profile[0].profile_picture
                                    var expertise = "" + user.profile[0].expertise
                                    view?.addCard(CollabCard(req.id,user.id,user.username,fullname,req.created,req.message,photoURL,expertise))
                                    view?.submitCardList()
                                },
                                {error->
                                    view?.writeLogMessage("e",TAG,"error while fetching user with id ${req.from_user} $error")
                                }
                        )
                        if(userObservable != null)
                            disposable.add(userObservable)

                    }

                },
                {error ->
                    view?.writeLogMessage("e",TAG,"error while fetching requests")
                }
        )
        if(requestsObservable != null)
            disposable.add(requestsObservable)
    }

    override fun subscribeAuthToken() {
        val userProfileSub = model.getAuthToken().subscribe { token ->
            this.view?.writeLogMessage("i", TAG, "fetching auth")

            fetchRequests(token.id)
        }
        disposable.add(userProfileSub)
    }

    override fun onAcceptButtonClick(item: CollabCard, position: Int) {
        val acceptrequestObservable  = model.acceptRequest(item.id).subscribe(
                {
                    view?.writeLogMessage("i",TAG,"Collaboration Request Accepted successfully")
                    view?.removeCard(item)
                    view?.submitCardList()

                },
                { error ->
                    view?.writeLogMessage("e",TAG,"Accept failed $error")
                }
        )
        if(acceptrequestObservable != null)
            disposable.add(acceptrequestObservable)

    }

    override fun onRejectButtonClick(item: CollabCard, position: Int) {
        val rejectrequestObservable  = model.acceptRequest(item.id).subscribe(
                {
                    view?.writeLogMessage("i",TAG,"Collaboration Request Rejected successfully")
                    view?.removeCard(item)
                    view?.submitCardList()
                },
                {error ->
                    view?.writeLogMessage("e",TAG,"Reject failed $error")
                }
        )
        if(rejectrequestObservable != null)
            disposable.add(rejectrequestObservable)
    }


}