package com.bounswe2020group3.paperlayer.home.adaptors

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.home.cards.EventCard
import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard

class MilestoneAdaptor : RecyclerView.Adapter<MilestoneAdaptor.milestoneViewHolder>() {
    private var milestones: List<MilestoneCard> = ArrayList()

    class milestoneViewHolder(val layout: View) : RecyclerView.ViewHolder(layout){
        var projectTitle = layout.findViewById<TextView>(R.id.projectTitle)
        var description = layout.findViewById<TextView>(R.id.description)
        var date = layout.findViewById<TextView>(R.id.date)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): milestoneViewHolder {
        return MilestoneAdaptor.milestoneViewHolder(
                LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_milestone, parent, false)
        )
    }

    override fun onBindViewHolder(holder: milestoneViewHolder, position: Int) {
        holder.projectTitle.text = milestones[position].projectTitle
        holder.description.text = milestones[position].description
        holder.date.text = milestones[position].date
    }
    fun submitList(milestoneCardlist: List<MilestoneCard>){
        milestones=milestoneCardlist
    }
    override fun getItemCount(): Int {
        return milestones.size
    }
}