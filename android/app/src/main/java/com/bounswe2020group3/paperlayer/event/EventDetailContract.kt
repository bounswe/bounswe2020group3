package com.bounswe2020group3.paperlayer.event

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.project.data.Event
import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Path

interface EventDetailContract {
    interface Presenter : Mvp.Presenter<View> {
        fun loadEvent(eventId: Int)
    }

    interface View : Mvp.View {
        fun showLoading()
        fun hideLoading()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
        fun updateEvent(event: Event)
        fun navigateBack()
    }

    interface Model {
        fun getEvent(eventId: Int): Single<Event>
    }

    interface Service {
        @GET("/api/events/{eventId}/")
        fun getEvent(@Path("eventId") eventId: Int): Single<Event>
    }
}