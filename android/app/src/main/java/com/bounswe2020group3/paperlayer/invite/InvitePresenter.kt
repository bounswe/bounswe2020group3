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
            //fetchAllUsers(token.id)
            //fetchAllInvited(2)
            fetchRecommendedUsers(token.id)
        }
        disposable.add(userProfileSub)
    }

    override fun fetchRecommendedUsers(ownerId : Int) {
        val getRecommsObservable = model.getRecommendedUsers(projectId)?.subscribe(
            { userlist ->
                for (user in userlist){
                    val invited : Boolean =  false //user.id.toString() in invitedIds
                    if (user.profile.isNotEmpty()) {
                        this.view?.addUserCard(
                            user.id,
                            user.username,
                            "${user.profile[0].name} ${user.profile[0].lastName}",
                            user.profile[0].expertise,
                            user.profile[0].profile_picture,
                            user.id,
                            invited)
                    }
                }
                this.view?.submitUserCardList()
                this.view?.writeLogMessage("i", TAG," submit fun is Called")
            },
            { it ->
                this.view?.writeLogMessage("i", TAG," fetching failed. $it")
                this.view?.showToast("$it")
            })
        if (getRecommsObservable != null) {
            disposable.add(getRecommsObservable)
        }

    }
    override fun fetchAllUsers(ownerId: Int) {
        var ids : ArrayList<String>  = ArrayList()
        var message : String = "invitedalready"

        val getUsersObservable = model.getAllUsers()?.subscribe(
                { userlist ->



                    val getInvitesObservable = model.getInvited(projectId).subscribe(
                            { invitelist ->

                                for( user in invitelist) {
                                    invitedIds.add(user.to_user)
                                    message = message + ", " + user.to_user
                                    invited.add(user)
                                }
                                view?.writeLogMessage("i", TAG,message)

                                for (user in userlist){
                                    val invited : Boolean =  user.id.toString() in invitedIds
                                    if (user.profile.isNotEmpty()) {
                                        this.view?.addUserCard(
                                                user.id,
                                                user.username,
                                                "${user.profile[0].name} ${user.profile[0].lastName}",
                                                user.profile[0].expertise,
                                                user.profile[0].profile_picture,
                                                user.id,
                                                invited)
                                    }
                                }
                                this.view?.submitUserCardList()
                                this.view?.writeLogMessage("i", TAG," submit fun is Called")
                            },
                            {error ->
                                this.view?.writeLogMessage("e", TAG, "invited fetching failed")
                            })
                    if (getInvitesObservable != null) {
                        disposable.add(getInvitesObservable)
                    }



                },
                { error ->
                    this.view?.writeLogMessage("e", TAG, "fetching failed $error")
                }
        )
        if (getUsersObservable != null) {
            disposable.add(getUsersObservable)
        }
    }


    override fun OnInviteButtonClicked(item: InviteCard, position: Int) {
        view?.writeLogMessage("i",TAG,"button pressed, ${item.id}, ${projectId}")
        if(!item.called) {
            val inviteUserObservable = model.inviteUsers(InviteRequest(item.id, projectId, "Come")).subscribe({response->

                view?.writeLogMessage("i", TAG, "invite sent")
                view?.writeLogMessage("i", TAG, "invite response: $response")

                view?.cardInviteCheck(item.id,position)
                disposable.clear()
                item.called = true;
                invited.add(response)
            }, {

                view?.showToast("Error while inviting ${item.username} " + it)
                disposable.clear()

            })
            disposable.add(inviteUserObservable)

        }
        else{
            var i = 0
            var index : Int =0
            while(i<invited.size)
            {
                view?.writeLogMessage("i",TAG,"try $i with ${invited[i]}")

                if(invited[i].to_user == item.id.toString()) {
                    index = invited[i].id
                    view?.writeLogMessage("i",TAG,"match $i")

                    break
                }
                i++
            }
            val uninviteUserObservable = model.uninvite(index).subscribe({
                view?.writeLogMessage("i",TAG,"uninvited 2")
                view?.cardUnInviteCheck(item.id,position)
                invited.removeAt(i)
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
        projectId = view.projectId
        subscribeAuthToken()
        view.writeLogMessage("i",TAG,"presenter set the view, projectID : $projectId")
        super.bind(view)
        this.view?.writeLogMessage("i", TAG,"Invite Presenter Created")


    }

    override fun unbind() {
        super.unbind()
        disposable.clear()

    }

}





