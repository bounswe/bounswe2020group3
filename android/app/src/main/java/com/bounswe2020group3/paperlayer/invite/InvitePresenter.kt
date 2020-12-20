package com.bounswe2020group3.paperlayer.invite

import androidx.core.view.get
import com.bounswe2020group3.paperlayer.invite.data.CollaborationInvite
import com.bounswe2020group3.paperlayer.invite.data.InviteRequest
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject
import kotlin.collections.ArrayList

private const val TAG = "InvitePresenter"


class InvitePresenter @Inject constructor(private var model: InviteContract.Model) : BasePresenter<InviteContract.View>(), InviteContract.Presenter {

    private var disposable = CompositeDisposable()
    private var projectId : Int = -1
    private val invitedIds : ArrayList<String> = ArrayList<String>()
    private val invited :  ArrayList<CollaborationInvite> = ArrayList<CollaborationInvite>()
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
            //fetchAllInvited(2)
        }
        disposable.add(userProfileSub)
    }

    override fun fetchAllUsers(ownerId: Int) {
        var ids : ArrayList<String>  = ArrayList()
        var message : String = "invitedalready"

        val getUsersObservable = model.getAllUsers()?.subscribe(
            { userlist ->



                val getInvitesObservable = model.getInvited(2).subscribe(
                        { invitelist ->

                            for( user in invitelist) {
                                invitedIds.add(user.to_user)
                                message = message + ", " + user.to_user
                                invited.add(user)
                            }
                            view?.writeLogMessage("i", TAG,message)

                            for (user in userlist){
                                var invited : Boolean =  user.id.toString() in invitedIds
                                if (user.profile.size >0)
                                    this.view?.addUserCard(user.username,"user.profile.get(0).name + user.profile.get(0).lastName",
                                            "", "it",user.id,invited)
                                else
                                    this.view?.addUserCard(user.username,"asd",
                                            "asd", "it",user.id,invited)
                                this.view?.writeLogMessage("i", TAG,user.username + " addUserCard is Called" )

                            }
                        },
                        {error ->
                            this.view?.writeLogMessage("e", TAG, "invited fetching failed")
                        })
                if (getInvitesObservable != null) {
                    disposable.add(getInvitesObservable)
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

        var message : String = "invitedalready"
        view?.writeLogMessage("i", TAG,message)

        val getUsersObservable = model.getInvited(2).subscribe(
                { invitelist ->
                    for( user in invitelist) {
                        invitedIds.add(user.to_user)
                        message = message + ", " + user.to_user
                        view?.writeLogMessage("i", TAG,message)

                    }
                },
                {error ->
                    this.view?.writeLogMessage("e", TAG, "invited fetching failed")
                })
        view?.writeLogMessage("i", TAG,message)
        if (getUsersObservable != null) {
            disposable.add(getUsersObservable)
        }
    }
    override fun OnInviteButtonClicked(item: InviteCard, position: Int) {
        view?.writeLogMessage("i",TAG,"invite button pressed, ${item.id}, ${projectId}")
        if(!item.called) {
            val inviteUserObservable = model.inviteUsers(InviteRequest(item.id, 2, "Come")).subscribe({

                view?.writeLogMessage("i", TAG, "invite sent")
                view?.cardInviteCheck(item.id,position)
                disposable.clear()
                item.called = true;
            }, {

                view?.showToast("Error while inviting ${item.username} " + it)
                disposable.clear()

            })
            disposable.add(inviteUserObservable)

        }
        else{
            var i = 0
            while(i<invited.size)
            {
                if(invited[i].to_user == item.id.toString())
                    i = invited[i].id
                i++
            }
            val uninviteUserObservable = model.uninvite(i).subscribe({
                view?.writeLogMessage("i",TAG,"uninvited 2")
                view?.cardUnInviteCheck(item.id,position)

                disposable.clear()
                item.called = false
            },
            {
                view?.writeLogMessage("i",TAG,"uninvite unsuccessful $it")
                disposable.clear()
            })
            disposable.add(uninviteUserObservable)
        }

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





