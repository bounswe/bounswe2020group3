package com.bounswe2020group3.paperlayer.profile.follow

import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.data.follow.Follow
import com.bounswe2020group3.paperlayer.data.follow.FollowType
import com.bounswe2020group3.paperlayer.data.user.User

interface OnUserClickListener {
    fun onUserClick(user: User)
}

/**
 * [RecyclerView.Adapter] that can display a [Follow].
 */
class FollowListAdapter(
    private val values: List<Follow>,
    private val clickListener: OnUserClickListener,
    private val followType: FollowType?
) : RecyclerView.Adapter<FollowListAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.fragment_user_item, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val follow = values[position]
        val user = if (followType == FollowType.FOLLOWER) {
            follow.fromUser
        } else {
            follow.toUser
        }
        holder.bind(user, clickListener)
    }

    override fun getItemCount(): Int = values.size

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        private val userFullName: TextView = view.findViewById(R.id.userFullName)
        private val userBio: TextView = view.findViewById(R.id.userBio)

        override fun toString(): String {
            return super.toString() + " '" + userFullName.text + "'"
        }

        fun bind(user: User, clickListener: OnUserClickListener) {
            val fullName = "${user.profile[0].name} ${user.profile[0].lastName}"
            userFullName.text = fullName
            userBio.text = user.profile[0].bio
            itemView.setOnClickListener {
                clickListener.onUserClick(user)
            }
        }
    }
}