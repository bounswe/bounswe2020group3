package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.invite.data.InviteRequest
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject
import kotlin.collections.ArrayList

private const val TAG = "InvitePresenter"


class InvitePresenter @Inject constructor(private var model: InviteContract.Model) : BasePresenter<InviteContract.View>(), InviteContract.Presenter {

    private var disposable = CompositeDisposable()
    private var projectId : Int = -1
    override fun setView(view: InviteContract.View) {
        this.view =view
        projectId = view.projectId
        view.writeLogMessage("i",TAG,"presenter set the view, projectID : $projectId")
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun subscribeAuthToken() {
        val userProfileSub = model.getAuthToken().subscribe { token ->
            fetchAllUsers(token.id)
        }
        disposable.add(userProfileSub)
    }

    fun fetchAllInvited() : ArrayList<String>{

        var ids : ArrayList<String>  = ArrayList()
        var message : String = "invitedalready"
        view?.writeLogMessage("i", TAG,message)

        val getUsersObservable = model.getInvited(36)?.subscribe(
                { invitelist ->
                    for( user in invitelist) {
                        ids.add(user.to_user)
                        message = message + ", " + user.to_user
                    }
                },
                {error ->
                    this.view?.writeLogMessage("e", TAG, "invited fetching failed")
                })
        view?.writeLogMessage("i", TAG,message)
        if (getUsersObservable != null) {
            disposable.add(getUsersObservable)
        }
        return ids
    }
    override fun fetchAllUsers(ownerId: Int) {
        var ids : ArrayList<String>  = ArrayList()
        var message : String = "invitedalready"

        val getUsersObservable = model.getAllUsers()?.subscribe(
            { userlist ->
                view?.writeLogMessage("i", TAG,message)

                val getUsersObservable = model.getInvited(36)?.subscribe(
                        { invitelist ->
                            for( user in invitelist) {
                                ids.add(user.to_user)
                                message = message + ", " + user.to_user
                            }
                        },
                        {error ->
                            this.view?.writeLogMessage("e", TAG, "invited fetching failed")
                        })
                view?.writeLogMessage("i", TAG,message)
                if (getUsersObservable != null) {
                    disposable.add(getUsersObservable)
                }
                for (user in userlist){
                    if (user.profile.size >0)
                        this.view?.addUserCard(user.username,"user.profile.get(0).name + user.profile.get(0).lastName",
                            "", "it",user.id,false)
                    else
                        this.view?.addUserCard(user.username,"asd",
                                "asd", "it",user.id,true)
                    this.view?.writeLogMessage("i", TAG,user.username + " addUserCard is Called" )

                }

                this.view?.submitUserCardList()
                this.view?.writeLogMessage("i", TAG," submit fun is Called")

            },
            { error ->
                this.view?.writeLogMessage("e", TAG, "fetching failed $error")
            }
        )
        if (getUsersObservable != null) {
            disposable.add(getUsersObservable)
        }
    }

    override fun fetchAllInvited(projectId: Int) {
        /*val getUsersObservable = model.getInvited(projectId)?.subscribe(
                { userlist ->
                    for (user in userlist){


                        this.view?.addUserCard(user.username,user.profile.get(0).name + user.profile.get(0).lastName,
                                    "", "it",user.id)

                        this.view?.writeLogMessage("i", TAG,user.username + " addUserCard is Called")

                    }
                    this.view?.submitUserCardList()
                    this.view?.writeLogMessage("i", TAG," submit fun is Called")

                },
                { error ->
                    this.view?.writeLogMessage("e", TAG, "fetching failed")
                }
        )
        if (getUsersObservable != null) {
            disposable.add(getUsersObservable)
        }*/
    }
    override fun OnInviteButtonClicked(item: InviteCard, position: Int) {
        view?.writeLogMessage("i",TAG,"invite button pressed, ${item.id}, ${projectId}")
        val inviteUserObservable =  model.inviteUsers(InviteRequest(item.id,projectId,"Come")).subscribe({
                view?.writeLogMessage("i",TAG,"invite sent")
                disposable.clear()

        }, {

                view?.showToast("Error while inviting ${item.username} " +it)
                disposable.clear()

        })


        disposable.add(inviteUserObservable)

    }
    override fun bind(view: InviteContract.View) {
        subscribeAuthToken()
        projectId = view.projectId
        view.writeLogMessage("i",TAG,"presenter set the view, projectID : $projectId")
        super.bind(view)
        this.view?.writeLogMessage("i", TAG,"Invite Presenter Created")


    }

    override fun unbind() {
        super.unbind()
        disposable.clear()

    }
}





