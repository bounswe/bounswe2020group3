package com.bounswe2020group3.paperlayer.notifications

import com.bounswe2020group3.paperlayer.home.data.NotificationResponse
import com.bounswe2020group3.paperlayer.home.data.NotificationUnreadCountResponse
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Response
import javax.inject.Inject

class NotificationModel @Inject constructor(sessionManager: Session): NotificationContract.Model {
    private var notificationService: NotificationContract.NotificationService = RetrofitProvider.instance.create(NotificationContract.NotificationService::class.java)
    private val authToken = "Token ${sessionManager.getToken().value?.token ?: ""}"

    override fun getNotifications(): Observable<NotificationResponse> {
        return notificationService.getNotifications(authToken)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    override fun readNotification(notificationId: Int): Observable<Response<Void>> {
        return notificationService.readNotification(authToken, notificationId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getUnreadNotificationCount(): Observable<NotificationUnreadCountResponse> {
        return notificationService.getUnreadNotificationCount(authToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }


}