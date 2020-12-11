package com.bounswe2020group3.paperlayer.home

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import java.util.zip.ZipEntry
import javax.inject.Inject
private const val TAG = "HomePresenter"

class HomePresenter @Inject constructor(private var model: HomeContract.Model) : BasePresenter<HomeContract.View>(),HomeContract.Presenter   {

    private var disposable = CompositeDisposable()

    override fun bind(view: HomeContract.View) {
        this.view?.writeLogMessage("i", TAG,"Invite Presenter Created")

        subscribeAuthToken()
        super.bind(view)
    }

    override fun unbind() {
        disposable.clear()
        super.unbind()
    }

    override fun setView(view: HomeContract.View) {
        this.view =view
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun subscribeAuthToken() {
        val userProfileSub = model.getAuthToken().subscribe { token ->
            fetchEvents(token.id)
        }
        disposable.add(userProfileSub)
    }
    override fun fetchEvents(ownerId : Int) {
        val getEventsObservable = model.getAllEvents()?.subscribe(
                { eventslist ->

                    for (event in eventslist) {
                        this.view?.writeLogMessage("i", TAG,event.title + " addUserCard is Called")
                    }

                },

                { error ->
                    this.view?.writeLogMessage("e", TAG, "fetching failed")
                }
        )
        if (getEventsObservable != null) {
            disposable.add(getEventsObservable)
        }
    }
}