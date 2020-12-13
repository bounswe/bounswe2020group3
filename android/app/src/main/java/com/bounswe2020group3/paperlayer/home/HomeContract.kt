package com.bounswe2020group3.paperlayer.home


import com.bounswe2020group3.paperlayer.home.cards.EventCard
import com.bounswe2020group3.paperlayer.home.data.Event
import com.bounswe2020group3.paperlayer.invite.InviteContract
import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.profile.data.User
import io.reactivex.Observable
import io.reactivex.subjects.BehaviorSubject
import retrofit2.http.GET

interface HomeContract {
    interface Presenter : Mvp.Presenter<View> {
        fun setView(view: HomeContract.View)
        fun showMessage(message: String)
        fun fetchEvents(ownerId : Int)
        fun subscribeAuthToken()
    }
    interface View: Mvp.View{
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun resetCardList()
        fun submitCardList()
        fun addCard(card : EventCard)

    }
    interface Model{
        fun getAllEvents(): Observable<List<Event>>?
        fun getAuthToken(): BehaviorSubject<AuthToken>

    }
    interface EventsService{
        @GET("/api/events/")
        fun getEvents(): Observable<List<Event>>
    }


}
