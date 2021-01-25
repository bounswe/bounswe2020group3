package com.bounswe2020group3.paperlayer.collaborationRequests

import com.bounswe2020group3.paperlayer.home.HomeContract
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.request.RequestItem

import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

private const val TAG = "CollabPresenter"

class CollabPresenter @Inject constructor(private var model: CollabContract.Model) :
    BasePresenter<CollabContract.CollabView>(), CollabContract.CollabPresenter {
    private var disposable = CompositeDisposable()
    private var projectId: Int = -1

    override fun bind(view: CollabContract.CollabView) {
        this.view?.writeLogMessage("i", TAG, "Event Presenter Created")
        projectId = view.projectId

        subscribeAuthToken()
        super.bind(view)
    }

    override fun unbind() {
        disposable.clear()
        super.unbind()
    }

    override fun setView(eventView: HomeContract.EventView) {
        projectId = view?.projectId!!
        view?.writeLogMessage("i", TAG, "$projectId 's reqs")
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun fetchRequests(ownerId: Int) {
        val requestsObservable = model.fetchRequests(projectId).subscribe(
            { requests ->
                view?.writeLogMessage(
                    "i",
                    TAG,
                    "${requests.size} reqs has been fetched for the project $projectId"
                )
                for (req in requests) {
                    val userObservable = model.getUser(req.from_user.toInt()).subscribe(
                        { user ->
                            val fullName = "" + user.profile[0].name + user.profile[0].lastName
                            val photoURL = "" + user.profile[0].profile_picture
                            val requestItem: RequestItem =
                                RequestItem(req.id, user.id, fullName, photoURL, req.message, req.to_project)
                            view?.addItem(requestItem)
                            view?.submitItemList()
                        },
                        { error ->
                            view?.writeLogMessage(
                                "e",
                                TAG,
                                "error while fetching user with id ${req.from_user} $error"
                            )
                        }
                    )
                    if (userObservable != null)
                        disposable.add(userObservable)

                }

            },
            { error ->
                view?.writeLogMessage("e", TAG, "error while fetching requests")
            }
        )
        if (requestsObservable != null)
            disposable.add(requestsObservable)
    }

    override fun subscribeAuthToken() {
        val userProfileSub = model.getAuthToken().subscribe { token ->
            this.view?.writeLogMessage("i", TAG, "fetching auth")

            fetchRequests(token.id)
        }
        disposable.add(userProfileSub)
    }

    override fun onAcceptButtonClick(item: RequestItem, position: Int) {
        val acceptRequestObservable = model.acceptRequest(item.id).subscribe(
            {
                view?.writeLogMessage("i", TAG, "Collaboration Request Accepted successfully")
                view?.removeItem(item)
                view?.submitItemList()

            },
            { error ->
                view?.writeLogMessage("e", TAG, "Accept failed $error")
            }
        )
        disposable.add(acceptRequestObservable)
    }

    override fun onRejectButtonClick(item: RequestItem, position: Int) {
        val rejectRequestObservable = model.rejectRequest(item.id).subscribe(
            {
                view?.writeLogMessage("i", TAG, "Collaboration Request Rejected successfully")
                view?.removeItem(item)
                view?.submitItemList()
            },
            { error ->
                view?.writeLogMessage("e", TAG, "Reject failed $error")
            }
        )
        disposable.add(rejectRequestObservable)
    }
}