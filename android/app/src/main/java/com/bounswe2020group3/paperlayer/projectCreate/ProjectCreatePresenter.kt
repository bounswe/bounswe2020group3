package com.bounswe2020group3.paperlayer.projectCreate

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Tag
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject


class ProjectCreatePresenter @Inject constructor(private var model: ProjectCreateContract.Model) : BasePresenter<ProjectCreateContract.View>(), ProjectCreateContract.Presenter {

    private var disposable = CompositeDisposable()
    private var events = mutableListOf<Event>()
    private var tags = mutableListOf<Tag>()

    override fun unbind() {
        disposable.clear()
        super.unbind()
    }

    override fun createProject(projectCreateRequest: ProjectCreateRequest) {
        view?.showProgress(true)
        val createProjectObservable = model.createProject(projectCreateRequest).subscribe({
            view?.showSuccess()
            disposable.clear()
        }, {
            view?.showProgress(false)
            disposable.clear()
            view?.showToast("Error while creating project $it")
        })
        disposable.add(createProjectObservable)
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

}