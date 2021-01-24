package com.bounswe2020group3.paperlayer.notifications.adapter

import android.graphics.Typeface
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.home.data.Notification

class NotificationAdapter(var notifications: List<Notification>): RecyclerView.Adapter<NotificationAdapter.NotificationViewHolder>() {
    var onItemClick: ((Notification) -> Unit)? = null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NotificationViewHolder {
        val itemView = LayoutInflater.from(parent.context)
                .inflate(R.layout.layout_list_item_notification, parent, false)
        return NotificationViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: NotificationViewHolder, position: Int) {
        holder.bind(notifications[position])
    }

    override fun getItemCount(): Int {
        return notifications.size
    }

    inner class NotificationViewHolder(itemView: View): RecyclerView.ViewHolder(itemView){

        private var information: TextView = itemView.findViewById(R.id.textViewInformation)
        private var date: TextView = itemView.findViewById(R.id.textViewDate)
        private var blueDot: ImageView = itemView.findViewById(R.id.imageBlueDot)

        init {
            itemView.setOnClickListener {
                onItemClick?.invoke(notifications[adapterPosition])
            }
        }

        fun bind(notification: Notification) {
            if(notification.unread) {
                blueDot.visibility = View.VISIBLE
                information.typeface = Typeface.DEFAULT_BOLD
                date.typeface = Typeface.DEFAULT_BOLD
            }
            else {
                blueDot.visibility = View.INVISIBLE
                information.typeface = Typeface.DEFAULT
                date.typeface = Typeface.DEFAULT
            }
            information.text = "${notification.actor.username} ${notification.verb}"
            date.text = notification.date
        }
    }
}