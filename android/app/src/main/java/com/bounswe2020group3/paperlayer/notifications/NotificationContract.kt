package com.bounswe2020group3.paperlayer.notifications

import com.bounswe2020group3.paperlayer.home.data.Notification
import com.bounswe2020group3.paperlayer.home.data.NotificationResponse
import com.bounswe2020group3.paperlayer.home.data.NotificationUnreadCountResponse
import com.bounswe2020group3.paperlayer.mvp.Mvp
import io.reactivex.Observable
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Header
import retrofit2.http.POST
import retrofit2.http.Path

interface NotificationContract {
    interface Presenter: Mvp.Presenter<View>{
        fun fetchNotifications()
        fun readNotification(notificationId: Int)
        fun fetchUnreadNotificationCount()

    }

    interface View: Mvp.View {
        fun showProgress(show: Boolean)
        fun showToast(message: String)
        fun initNotificationAdapter(notificationList: List<Notification>)
        fun updateNotificationIcon(notificationCount: Int)
    }

    interface Model {
        fun getNotifications(): Observable<NotificationResponse>
        fun readNotification(notificationId: Int): Observable<Response<Void>>
        fun getUnreadNotificationCount(): Observable<NotificationUnreadCountResponse>
    }

    interface NotificationService {
        @GET("/api/notifications/")
        fun getNotifications(@Header("Authorization") authorization: String): Observable<NotificationResponse>

        @POST("/api/notifications/{id}/mark_as_read/")
        fun readNotification(@Header("Authorization") authorization: String, @Path("id") notificationId: Int): Observable<Response<Void>>

        @GET("/api/notifications/unread_count/")
        fun getUnreadNotificationCount(@Header("Authorization") authorization: String): Observable<NotificationUnreadCountResponse>
    }


}