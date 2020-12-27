package com.bounswe2020group3.paperlayer.home

import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard
import com.bounswe2020group3.paperlayer.home.cards.ProjectUpdateCard
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject
private const val TAG = "MilestonePresenter"

class MilestonePresenter @Inject constructor(private var model: HomeContract.Model) : BasePresenter<HomeContract.MileStoneView>(), HomeContract.MileStonePresenter  {
    private var disposable = CompositeDisposable()

    override fun bind(view: HomeContract.MileStoneView) {
        this.view?.writeLogMessage("i", TAG,"Milestone Presenter Created")

        subscribeAuthToken()
        super.bind(view)
    }

    override fun unbind() {
        disposable.clear()

        super.unbind()
    }

    override fun setView(milestoneView: HomeContract.MileStoneView) {
        this.view =milestoneView
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun fetchMilestones(ownerId: Int) {
    val getMilestonesObservable = model.getMilestones().subscribe(
        {list->
            for(milestone in list.result){
                this.view?.addCard(MilestoneCard(milestone.id,milestone.project_name,milestone.description,milestone.project,milestone.date))

            }
            this.view?.writeLogMessage("i", TAG,"Fetching finished.")
            this.view?.submitCardList()
        },{error->
        this.view?.writeLogMessage("e", TAG,"Error in fetching all milestones of owner $ownerId, $error")
    })

        disposable.add(getMilestonesObservable)
    }

    override fun subscribeAuthToken() {
        val userProfileSub = model.getAuthToken().subscribe { token ->
            this.view?.writeLogMessage("i", TAG, "fetching auth")

            fetchMilestones(token.id)
        }
        disposable.add(userProfileSub)
    }

}