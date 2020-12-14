package com.bounswe2020group3.paperlayer.profile.list

import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.profile.data.User

interface OnUserClickListener {
    fun onUserClick(user: User)
}

/**
 * [RecyclerView.Adapter] that can display a [User].
 */
class UserListAdapter(
    private val values: List<User>,
    private val clickListener: OnUserClickListener
) : RecyclerView.Adapter<UserListAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.fragment_user_item, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val user = values[position]
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