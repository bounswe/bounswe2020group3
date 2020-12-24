package com.bounswe2020group3.paperlayer.home

import android.view.View
import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard
import com.bounswe2020group3.paperlayer.home.cards.ProjectUpdateCard
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

    }

    override fun OnInviteButtonClicked(Item: ProjectUpdateCard, position: Int) {

    }
}