package com.bounswe2020group3.paperlayer.profile.follow

import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.data.follow.Follow
import com.bounswe2020group3.paperlayer.data.follow.ListableFollow
import com.bounswe2020group3.paperlayer.data.user.User
import com.squareup.picasso.Picasso

/**
 * [RecyclerView.Adapter] that can display a [Follow].
 */
class FollowListAdapter(
        private val values: List<ListableFollow>,
        private val clickListener: FollowContract.OnUserClickListener,
        private val followButtonClickListener: FollowContract.OnFollowButtonClickListener,
        private val followType: FollowType?
) : RecyclerView.Adapter<FollowListAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
                .inflate(R.layout.fragment_follow_item, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val follow = values[position]
        val user = when (followType) {
            FollowType.FOLLOWER -> {
                follow.fetchFromUser()
            }
            FollowType.FOLLOWING -> {
                follow.fetchToUser()
            }
            else -> {
                follow.fetchFromUser()
            }
        }
        holder.bind(user, follow.id)
    }

    override fun getItemCount(): Int = values.size

    inner class ViewHolder(private val view: View) : RecyclerView.ViewHolder(view) {
        private val userFullName: TextView = view.findViewById(R.id.userFullName)
        private val imageViewProfileAvatar: ImageView = view.findViewById(R.id.imageViewProfileAvatar)

        private val buttonFollowListFollow: Button = view.findViewById(R.id.buttonFollowListFollow)
        private val buttonFollowListUnfollow: Button = view.findViewById(R.id.buttonFollowListUnfollow)
        private val buttonFollowListRequestSent: Button = view.findViewById(R.id.buttonFollowListRequestSent)
        private val groupFollowListAcceptReject: View = view.findViewById(R.id.buttonGroupAcceptRejectRequest)
        private val buttonFollowListAccept: Button = view.findViewById(R.id.buttonFollowListAcceptRequest)
        private val buttonFollowListReject: Button = view.findViewById(R.id.buttonFollowListRejectRequest)

        override fun toString(): String {
            return super.toString() + " '" + userFullName.text + "'"
        }

        fun bind(user: User, followId: Int) {
            val fullName = "${user.profile[0].name} ${user.profile[0].lastName}"
            userFullName.text = fullName
            itemView.setOnClickListener {
                clickListener.onUserClick(user)
            }

            val imageUrl = user.profile[0].profile_picture
            if(imageUrl != null && imageUrl != "") {
                Picasso.get().load(imageUrl).into(imageViewProfileAvatar)
            }

            // Button displays
            buttonFollowListFollow.visibility = View.GONE
            buttonFollowListUnfollow.visibility = View.GONE
            buttonFollowListRequestSent.visibility = View.GONE
            groupFollowListAcceptReject.visibility = View.GONE

            if (followType == FollowType.FOLLOWER || followType == FollowType.FOLLOWING) {
                when {
                    user.isFollowing -> {
                        buttonFollowListUnfollow.visibility = View.VISIBLE
                    }
                    user.isFollowRequestSent -> {
                        buttonFollowListRequestSent.visibility = View.VISIBLE
                    }
                    else -> {
                        buttonFollowListFollow.visibility = View.VISIBLE
                    }
                }
            } else if (followType == FollowType.FOLLOW_REQUEST) {
                groupFollowListAcceptReject.visibility = View.VISIBLE
            }

            // Button click listeners
            buttonFollowListFollow.setOnClickListener {
                followButtonClickListener.onFollowButtonClick(user)
            }

            // Button click listeners
            buttonFollowListUnfollow.setOnClickListener {
                followButtonClickListener.onUnfollowButtonClick(followId)
            }

            // Button click listeners
            buttonFollowListAccept.setOnClickListener {
                followButtonClickListener.onAcceptRequestClick(followId, user)
            }

            // Button click listeners
            buttonFollowListReject.setOnClickListener {
                followButtonClickListener.onRejectRequestClick(followId, user)
            }
        }
    }
}