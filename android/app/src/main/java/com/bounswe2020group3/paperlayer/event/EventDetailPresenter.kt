package com.bounswe2020group3.paperlayer.event

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import javax.inject.Inject

class EventDetailPresenter @Inject constructor(
        private val eventDetailModel: EventDetailModel
) : BasePresenter<EventDetailContract.View>(), EventDetailContract.Presenter {

    override fun loadEvent(eventId: Int) {
        this.view?.showLoading()
        val sub = this.eventDetailModel.getEvent(eventId)
                .subscribe(
                        { event ->
                            this.view?.updateEvent(event)
                            this.view?.hideLoading()
                        },
                        { error ->
                            this.view?.showErrorToast("An error occurred while fetching event.")
                            this.view?.navigateBack()
                            this.view?.hideLoading()
                        }
                )
        compositeDisposable?.add(sub)
    }
}