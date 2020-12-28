package com.bounswe2020group3.paperlayer.projectEdit

import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Tag
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class ProjectEditPresenter @Inject constructor(private var model: ProjectEditContract.Model) : BasePresenter<ProjectEditContract.View>(), ProjectEditContract.Presenter {
    private var disposable = CompositeDisposable()
    private var events = mutableListOf<Event>()
    private var tags = mutableListOf<Tag>()

    override fun unbind() {
        disposable.clear()
        super.unbind()
    }
    override fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest) {
        view?.showProgress(true)
        val editProjectObservable = model.editProject(projectID, projectEditRequest).subscribe({
            view?.showProgress(false)
            view?.showSuccess()
            disposable.clear()
        }, {
            view?.showProgress(false)
            disposable.clear()
            view?.showToast("Error while editing project")
        })
        disposable.add(editProjectObservable)
    }

    override fun navigateToProjectDetail(projectID: Int?) {
        val bundle = bundleOf("projectID" to projectID )
        (view as Fragment).view?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectFragmentFromProjectEditFragment, bundle) }
    }

    override fun fetchEvents() {
        val fetchEventsObservable = model.fetchEvents().subscribe({
            events = it as MutableList<Event>
            view?.createEventSpinner()
        }, {
            view?.showToast("FAILED TO FETCH EVENTS")
        })
        disposable.add(fetchEventsObservable)
    }

    override fun fetchTags() {
        val fetchTagsObservable = model.fetchTags().subscribe({
            tags = it as MutableList<Tag>
            view?.createTagSelectDialog()
        }, {
            view?.showToast("FAILED TO FETCH TAGS")
        })
        disposable.add(fetchTagsObservable)
    }

    override fun getTagList(): List<Tag> = tags
    override fun getEventList(): List<Event> = events

    override fun getCurrentTagIndex(currentTagList: List<Tag>?): ArrayList<Int> {
        val tagIndexes = arrayListOf<Int>()
        currentTagList?.forEach { currentTag ->
            tagIndexes.add(tags.indexOf(tags.find {
                it.id == currentTag.id
            }))
        }
        return tagIndexes
    }
}