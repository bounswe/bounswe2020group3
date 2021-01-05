package com.bounswe2020group3.paperlayer.search


import androidx.core.os.bundleOf
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.project.data.Tag
import com.bounswe2020group3.paperlayer.search.data.Search
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
        view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectFromSearch,bundle) }
    }

    override fun navigateToUser(userID: Int) {
        //Fix id problem Currently tries profile ID instead of user ID
        val bundle = bundleOf("userID" to userID )
        view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToUserFromSearch,bundle) }
    }

    override fun navigateToEvent(eventID: Int) {
        val bundle = bundleOf("eventID" to eventID )
        view?.getLayout()?.let { Navigation.findNavController(it).navigate(R.id.navigateToEventDetailFromSearch,bundle) }
    }

    override fun searchRequest(searchFilter: Search) {
        this.view?.writeLogMessage("i", TAG, "Getting results of search with keyword ${searchFilter.keyword} ...")
        val getProjectObservable = model.searchRequest(searchFilter).subscribe(
                { searchResponse ->
                    when (searchFilter.searchType) {
                        "project" -> {
                            // project search
                            for (project in searchResponse.projects!!) {
                                var projectIconType: Int
                                when (project.project_type) {
                                    "conference" -> projectIconType = 0
                                    "instutution" -> projectIconType = 1
                                    "journal" -> projectIconType = 2
                                    else -> projectIconType = 3
                                }
                                this.view?.addSearchCard(0, projectIconType, project.name, project.description, project.owner, project.tags, project.id)
                                this.view?.writeLogMessage("i", TAG, "Project Fetched + " + project.name)
                            }
                        }
                        "profile" -> {
                            //profile search
                            for (profile in searchResponse.profiles!!) {
                                var title = "No Name"
                                var owner= "No owner"
                                title = profile.name + profile.lastName
                                owner= profile.owner.toString()
                                this.view?.addSearchCard(1, 0, title, "", owner, listOf<Tag>(), profile.ownerId)
                                this.view?.writeLogMessage("i", TAG, "User Fetched + ")
                            }
                        }
                        "event" -> {
                            //event search
                            for (event in searchResponse.events!!) {
                                this.view?.addSearchCard(2,0,event.title,event.description,event.date,listOf<Tag>(),event.id)
                                this.view?.writeLogMessage("i", TAG,"Event Fetched")
                            }
                        }
                    }
                    this.view?.hideLoading()
                    this.view?.writeLogMessage("i", TAG,"Search results fetched successfully.")
                    this.view?.submitSearchCardList()
                },
                { error ->
                    this.view?.writeLogMessage("e", TAG,"Error in getting results of search with keyword  ${searchFilter.keyword}")
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
