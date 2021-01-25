package com.bounswe2020group3.paperlayer.notifications

import com.bounswe2020group3.paperlayer.home.data.Notification
import com.bounswe2020group3.paperlayer.home.data.NotificationType
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import timber.log.Timber
import javax.inject.Inject

class NotificationPresenter @Inject constructor(private var model: NotificationContract.Model): BasePresenter<NotificationContract.View>(), NotificationContract.Presenter {

    private var disposable = CompositeDisposable()

    override fun unbind() {
        disposable.clear()
        super.unbind()
    }

    override fun fetchNotifications() {
        val getNotificationsObservable = model.getNotifications().subscribe({ it ->
            view?.showProgress(false)
            fetchUnreadNotificationCount()
            val notificationList = arrayListOf<Notification>()
            it.notificationsList?.forEach { notification ->
                when (notification.notificationType) {
                    NotificationType.INVITE -> {
                        notification.project_invite?.let {
                            notificationList.add(notification)
                        }
                    }
                    NotificationType.FOLLOW_REQUEST -> {
                        notification.follow_request?.let {
                            notificationList.add(notification)
                        }
                    }
                    NotificationType.REQUEST -> {
                        notification.collaboration_request?.let {
                            notificationList.add(notification)
                        }
                    }
                    else -> {
                        notificationList.add(notification)
                    }
                }
            }
            view?.initNotificationAdapter(notificationList)
        }, {
            view?.showProgress(false)
        }
        )
        disposable.add(getNotificationsObservable)
    }

    override fun fetchUnreadNotificationCount() {
        val getUnreadNotificationCountObservable = model.getUnreadNotificationCount().subscribe({
            view?.updateNotificationIcon(it.unread_count)
        }, {
            view?.showToast("Error while getting notification count!")
        })
        disposable.add(getUnreadNotificationCountObservable)
    }

    override fun readNotification(notificationId: Int) {
        val readNotificationObservable = model.readNotification(notificationId).subscribe({
            fetchNotifications()
        }, {
            val error = it
        })
        disposable.add(readNotificationObservable)
    }
}