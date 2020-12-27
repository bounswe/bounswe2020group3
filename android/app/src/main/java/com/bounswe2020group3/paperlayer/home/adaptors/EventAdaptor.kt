package com.bounswe2020group3.paperlayer.home.adaptors

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.home.cards.EventCard
import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard
import com.bounswe2020group3.paperlayer.project.ProjectCard
interface OnCardClickListenerForEvents{
    fun onViewButtonClick(item : EventCard, position: Int)
}
class EventAdaptor(var clickListener: OnCardClickListenerForEvents) : RecyclerView.Adapter<EventAdaptor.eventViewHolder>(){
    private var events: List<EventCard> = ArrayList()

    class eventViewHolder(val layout: View) :RecyclerView.ViewHolder(layout){
        val title = layout.findViewById<TextView>(R.id.title)
        val description = layout.findViewById<TextView>(R.id.description)
        val deadline = layout.findViewById<TextView>(R.id.deadline)
        val date= layout.findViewById<TextView>(R.id.date)
        val event_type= layout.findViewById<TextView>(R.id.event_type)
        val viewButton= layout.findViewById<Button>(R.id.buttonView)

        fun bind(item : EventCard, action: OnCardClickListenerForEvents) {

            title.text = item.title
            description.text = item.description
            date.text = item.date
            event_type.text = item.event_type
            deadline.text = item.deadline

            viewButton.setOnClickListener{
                action.onViewButtonClick(item,adapterPosition)
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): eventViewHolder {
        return EventAdaptor.eventViewHolder(
                LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_event, parent, false)
        )
    }

    override fun onBindViewHolder(holder: eventViewHolder, position: Int) {
        when(holder){
            is EventAdaptor.eventViewHolder ->{
                holder.bind(events[position],clickListener)
            }
        }
    }
    fun submitList(eventCardsList: List<EventCard>){
        events=eventCardsList
    }

    override fun getItemCount(): Int {
        return events.size
    }
}