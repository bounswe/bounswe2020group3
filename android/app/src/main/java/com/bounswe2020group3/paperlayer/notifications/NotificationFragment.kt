package com.bounswe2020group3.paperlayer.notifications

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.home.data.Notification
import com.bounswe2020group3.paperlayer.home.data.NotificationType
import com.bounswe2020group3.paperlayer.notifications.adapter.NotificationAdapter
import com.bounswe2020group3.paperlayer.profile.follow.FollowType
import kotlinx.android.synthetic.main.fragment_notification.*
import javax.inject.Inject


class NotificationFragment : Fragment(), NotificationContract.View {

    @Inject
    lateinit var presenter: NotificationContract.Presenter
    private var adapter = NotificationAdapter(listOf())

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        presenter.bind(this)

        return inflater.inflate(R.layout.fragment_notification, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        presenter.fetchNotifications()
    }

    override fun showProgress(show: Boolean) {
        if (show) {
            progressBar?.visibility = View.VISIBLE
        } else {
            progressBar?.visibility = View.GONE
        }
    }

    override fun showToast(message: String) {
        if(context!=null) {
            Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
        }
    }

    override fun initNotificationAdapter(notificationList: List<Notification>) {
        recyclerViewNotification.layoutManager = LinearLayoutManager(context)
        recyclerViewNotification.adapter = adapter
        adapter.onItemClick = {
            if(it.unread) {
                presenter.readNotification(it.id)
            }

            when(it.notificationType) {
                NotificationType.PROJECT -> {
                    val bundle = bundleOf("projectID" to it.project?.id )
                    Navigation.findNavController(requireView()).navigate(R.id.projectFragment, bundle)

                }
                NotificationType.REQUEST -> {
                    val bundle = bundleOf("projectID" to it.collaboration_request?.to_project )
                    Navigation.findNavController(requireView()).navigate(R.id.collabFragment, bundle)
                }
                NotificationType.FOLLOW_REQUEST -> {
                    val followRequestBundle = bundleOf("followType" to FollowType.FOLLOW_REQUEST)
                    Navigation.findNavController(requireView()).navigate(R.id.followListFragment, followRequestBundle)
                }
                NotificationType.FOLLOW -> {
                    val followerBundle = bundleOf("followType" to FollowType.FOLLOWER)
                    Navigation.findNavController(requireView()).navigate(R.id.followListFragment, followerBundle)
                }
                NotificationType.MILESTONE -> {
                    val bundle = bundleOf("projectID" to it.milestone?.project )
                    Navigation.findNavController(requireView()).navigate(R.id.projectFragment, bundle)
                }
                NotificationType.RATING, NotificationType.COMMENT -> {
                    Navigation.findNavController(requireView()).navigate(R.id.profileFragment)
                }
                NotificationType.INVITE -> {
                    val bundle = bundleOf("projectID" to it.project_invite?.to_project )
                    it.project_invite?.to_project?.let {
                        Navigation.findNavController(requireView()).navigate(R.id.projectFragment, bundle)
                    }
                }
            }

        }
        recyclerViewNotification.setHasFixedSize(true)
        adapter.notifications = notificationList
        adapter.notifyDataSetChanged()

    }
    override fun updateNotificationIcon(notificationCount: Int) {
        (activity as MainActivity).apply {
            setNotificationCount(notificationCount)
            setupBadge()
        }
    }

}