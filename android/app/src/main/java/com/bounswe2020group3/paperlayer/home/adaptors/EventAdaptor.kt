package com.bounswe2020group3.paperlayer.home.adaptors

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.home.cards.EventCard
import com.bounswe2020group3.paperlayer.project.ProjectCard

class EventAdaptor() : RecyclerView.Adapter<EventAdaptor.eventViewHolder>(){
    private var events: List<EventCard> = ArrayList()

    class eventViewHolder(val layout: View) :RecyclerView.ViewHolder(layout){
        val title = layout.findViewById<TextView>(R.id.title)
        val description = layout.findViewById<TextView>(R.id.description)
        val deadline = layout.findViewById<TextView>(R.id.deadline)
        val date= layout.findViewById<TextView>(R.id.date)
        val event_type= layout.findViewById<TextView>(R.id.event_type)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): eventViewHolder {
        return EventAdaptor.eventViewHolder(
                LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_event, parent, false)
        )
    }

    override fun onBindViewHolder(holder: eventViewHolder, position: Int) {
        holder.title.text = events[position].title
        holder.description.text = events[position].description
        holder.deadline.text = events[position].deadline
        holder.date.text = events[position].date
        holder.event_type.text = events[position].event_type

    }
    fun submitList(eventCardsList: List<EventCard>){
        events=eventCardsList
    }

    override fun getItemCount(): Int {
        return events.size
    }
}