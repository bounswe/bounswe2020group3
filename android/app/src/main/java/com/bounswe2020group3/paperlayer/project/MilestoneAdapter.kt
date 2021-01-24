package com.bounswe2020group3.paperlayer.project

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.layout_list_item_project_milestone.view.*

class MilestoneAdapter() : RecyclerView.Adapter<MilestoneAdapter.MilestoneViewHolder>() {

    private var milestones: List<MilestoneCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MilestoneViewHolder {
        return MilestoneViewHolder(
            LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_project_milestone, parent, false )
        )
    }

    override fun onBindViewHolder(holder: MilestoneViewHolder, position: Int) {
        when(holder){
            is MilestoneViewHolder ->{
                holder.bind(milestones.get(position))
            }
        }
    }

    override fun getItemCount(): Int {
        return milestones.size
    }

    fun submitList(milestoneCardList: List<MilestoneCard>){
        milestones=milestoneCardList
    }

    class MilestoneViewHolder  constructor(
        itemView: View
    ): RecyclerView.ViewHolder(itemView) {

        var milestoneDescription: TextView =itemView.textViewMilestoneDescription
        var milestoneDate: TextView =itemView.textViewMilestoneDate

        fun bind(milestoneCard: MilestoneCard){
            milestoneDescription.setText(milestoneCard.milestone.description)
            milestoneDate.setText(milestoneCard.milestone.date)
        }
    }
}