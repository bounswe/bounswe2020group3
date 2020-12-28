package com.bounswe2020group3.paperlayer.project

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.layout_list_item_project_member.view.*

interface OnMemberCardClickListener {
    fun onCardClickListener(userId: Int)
}

class MembersAdapter(val clickListener: OnMemberCardClickListener): RecyclerView.Adapter<MembersAdapter.MemberViewHolder>() {

    private var members: List<MemberCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MembersAdapter.MemberViewHolder {
        return MembersAdapter.MemberViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.layout_list_item_project_member, parent, false)
        )
    }

    override fun onBindViewHolder(holder: MembersAdapter.MemberViewHolder, position: Int) {
        when(holder){
            is MembersAdapter.MemberViewHolder ->{
                holder.bind(members.get(position), clickListener)
            }
        }
    }


    override fun getItemCount(): Int {
        return members.size
    }

    fun submitList(memberCardList: List<MemberCard>){
        members=memberCardList
    }

    class MemberViewHolder  constructor(
        itemView: View
    ): RecyclerView.ViewHolder(itemView) {

        var memberUsername: TextView =itemView.textViewProjectMemberUsername

        fun bind(memberCard: MemberCard, clickListener: OnMemberCardClickListener){
            memberUsername.setText(memberCard.username)

            itemView.setOnClickListener {
                clickListener.onCardClickListener(memberCard.userId)
            }
        }

    }


}