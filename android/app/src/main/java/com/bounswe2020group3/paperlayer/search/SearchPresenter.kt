package com.bounswe2020group3.paperlayer.search


import androidx.core.os.bundleOf
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

private const val TAG = "SearchPresenter"

class SearchPresenter @Inject constructor(private var model:SearchContract.Model):BasePresenter<SearchContract.View>(),SearchContract.Presenter {

    //Disposable
    private var disposable = CompositeDisposable()

    override fun setView(view: SearchContract.View) {
        this.view =view
    }

    override fun bind(view: SearchContract.View) {
        super.bind(view)
        this.view?.writeLogMessage("i", TAG,"Search Presenter Created")
    }

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun navigateToProject(projectID: Int) {
        val bundle = bundleOf("projectID" to projectID )
        //FIX
        //view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectFromProjectMainFragment,bundle) }
    }

    override fun navigateToUser(userID: Int) {
        val bundle = bundleOf("userID" to userID )
        //FIX
        //view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectFromProjectMainFragment,bundle) }
    }

    override fun navigateToEvent(eventID: Int) {
        val bundle = bundleOf("eventID" to eventID )
        //FIX
        //view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectFromProjectMainFragment,bundle) }
    }

    override fun searchRequest(keyword: String) {
        this.view?.writeLogMessage("i", TAG, "Getting results of search with keyword $keyword ...")
        val getProjectObservable = model.searchProject(keyword).subscribe(
                { projectList ->
                    for (project in projectList){
                        //this.view?.addProjectCard(project.name,project.description,project.owner,project.id,project.project_type)
                        this.view?.writeLogMessage("i", TAG,"Project Fetched + " + project.project_type)
                    }
                    this.view?.writeLogMessage("i", TAG,"Results fetched.")
                    //this.view?.submitProjectCardList()
                },
                { error ->
                    this.view?.writeLogMessage("e", TAG,"Error in getting results of search with keyword  $keyword")
                }
        )
        disposable.add(getProjectObservable)
    }

    override fun getAllProjects() {
        this.view?.writeLogMessage("i", TAG, "Fetching all projects ")
        val getProjectObservable = model.getAllProjects().subscribe(
                { projectList ->
                    for (project in projectList){
                        var projectIconType: Int
                        /*when(project.project_type){
                            "conference"->projectIconType=0
                            "instutution"->projectIconType=1
                            "journal"->projectIconType=2
                            else->projectIconType=3
                        }*/
                        projectIconType=3//Fix after API updates
                        this.view?.addSearchCard(0,projectIconType,project.name,project.description,project.owner,listOf<String>(),project.id)
                        this.view?.writeLogMessage("i", TAG,"Project Fetched + ")
                    }
                    this.view?.writeLogMessage("i", TAG,"Fetching finished.")
                    this.view?.submitSearchCardList()
                },
                { error ->
                    this.view?.writeLogMessage("e", TAG,"Error in fetching all projects")
                }
        )
        disposable.add(getProjectObservable)
    }

    override fun getAllUsers() {
        this.view?.writeLogMessage("i", TAG, "Fetching all users ")
        val getProjectObservable = model.getAllUsers().subscribe(
                { userList ->
                    for (user in userList){
                        var title=""
                        if(!user.profile.isEmpty())
                        {
                            title=user.profile[0].name+user.profile[0].lastname
                        }
                        this.view?.addSearchCard(1,0,title,"",user.username,listOf<String>(),user.id)
                        this.view?.writeLogMessage("i", TAG,"User Fetched + ")
                    }
                    this.view?.writeLogMessage("i", TAG,"Fetching finished.")
                    this.view?.submitSearchCardList()
                },
                { error ->
                    this.view?.writeLogMessage("e", TAG,"Error in fetching all users")
                }
        )
        disposable.add(getProjectObservable)
    }

    override fun getAllEvents() {
        this.view?.writeLogMessage("i", TAG, "Fetching all events ")
        val getProjectObservable = model.getAllEvents().subscribe(
                { eventList ->
                    for (event in eventList){
                        this.view?.addSearchCard(2,0,event.title,event.description,event.date,listOf<String>(),event.id)
                        this.view?.writeLogMessage("i", TAG,"Event Fetched")
                    }
                    this.view?.writeLogMessage("i", TAG,"Fetching finished.")
                    this.view?.submitSearchCardList()
                },
                { error ->
                    this.view?.writeLogMessage("e", TAG,"Error in fetching all events")
                }
        )
        disposable.add(getProjectObservable)
    }

    override fun onProjectClicked(item: SearchCard, position: Int) {
        navigateToProject(item.id)
    }

    override fun onUserClicked(item: SearchCard, position: Int) {
        navigateToUser(item.id)
    }

    override fun onEventClicked(item: SearchCard, position: Int) {
        navigateToEvent(item.id)
    }


}