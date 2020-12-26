package com.bounswe2020group3.paperlayer.event

import com.bounswe2020group3.paperlayer.project.data.Event
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Retrofit
import javax.inject.Inject

class EventDetailModel @Inject constructor(retrofit: Retrofit) : EventDetailContract.Model {

    private val eventService = retrofit.create(EventDetailContract.Service::class.java)

    override fun getEvent(eventId: Int): Single<Event> {
        return eventService.getEvent(eventId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}