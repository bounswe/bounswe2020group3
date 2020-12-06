package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.project.ProjectMainContract
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class InvitePresenter @Inject constructor(private var model: InviteContract.Model) : BasePresenter<InviteContract.View>(), InviteContract.Presenter {

    private var disposable = CompositeDisposable()

    override fun setView(view: InviteContract.View) {
        this.view =view
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun subscribeAuthToken() {
        val userProfileSub = model.getAuthToken().subscribe { token ->
            fetchAllUsers(token.id)
        }
        disposable.add(userProfileSub)    }

    override fun fetchAllUsers(ownerId: Int) {
        val getUsersObservable = model.getAllUsers()?.subscribe(
            { userlist ->
                for (user in userlist){
                    user.profile.get(0).photoUrl?.let {
                        user.profile.get(0).expertise?.let { it1 ->
                            this.view?.addUserCard(user.username,user.profile.get(0).name + user.profile.get(0).lastName,
                                    it1, it)
                        }
                    }
                }
                this.view?.submitUserCardList()
            },
            { error ->
                showMessage("Fetching failed")
            }
        )
        if (getUsersObservable != null) {
            disposable.add(getUsersObservable)
        }
    }

    override fun bind(view: InviteContract.View) {
        super.bind(view)
        subscribeAuthToken()

    }

    override fun unbind() {
        super.unbind()
        disposable.clear()

    }

}