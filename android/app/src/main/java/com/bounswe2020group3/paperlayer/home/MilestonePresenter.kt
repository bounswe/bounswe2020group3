package com.bounswe2020group3.paperlayer.home

import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard
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
        /*
        this.view?.writeLogMessage("i", TAG, "Fetching all projects of owner $ownerId ...")
        val getProjectObservable = model.getAllProjects(ownerId).subscribe(
                { projectList ->
                    for (project in projectList){
                        var list = project.milestones
                        this.view?.writeLogMessage("i", TAG,"Project Fetched + " + project.project_type)
                        for(milestone in list){
                            this.view?.writeLogMessage("i", TAG,"milestone Fetched + " + milestone.description)

                            this.view?.addCard(MilestoneCard(project.name,milestone.description,project.id,milestone.date))
                        }
                        this.view?.writeLogMessage("i", TAG,"Project Fetched + " + project.project_type)
                    }
                    this.view?.writeLogMessage("i", TAG,"Fetching finished.")
                    this.view?.submitCardList()
                },
                { error ->
                    this.view?.writeLogMessage("e", TAG,"Error in fetching all projects of owner $ownerId")
                }
        )
        disposable.add(getProjectObservable)*/
    }

    override fun subscribeAuthToken() {
        val userProfileSub = model.getAuthToken().subscribe { token ->
            this.view?.writeLogMessage("i", TAG, "fetching auth")

            fetchMilestones(token.id)
        }
        disposable.add(userProfileSub)
    }
}