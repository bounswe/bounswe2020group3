package com.bounswe2020group3.paperlayer.project

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.squareup.picasso.Picasso
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
        var memberAvatar: ImageView = itemView.imageViewMemberAvatar

        fun bind(memberCard: MemberCard, clickListener: OnMemberCardClickListener){
            val fullName = "${memberCard.user.profile[0].name} ${memberCard.user.profile[0].lastName}"
            memberUsername.text = fullName

            val imageUrl = memberCard.user.profile[0].profilePicture
            if (imageUrl != null && imageUrl != "") {
                Picasso.get().load(imageUrl).into(memberAvatar)
            }

            itemView.setOnClickListener {
                clickListener.onCardClickListener(memberCard.user.id)
            }
        }

    }


}