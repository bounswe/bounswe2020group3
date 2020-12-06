package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.project.ProjectCard



import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.layout_list_item_project.view.*
import kotlinx.android.synthetic.main.layout_list_item_userinvites.view.*

//Interface to communicate between fragment and recyclerview items
interface OnCardClickListener{
    fun onViewButtonClick(item: InviteCard, position: Int )
    fun onEditButtonClick(item: InviteCard, position: Int )
}


class UserInviteAdapter(var clickListener: OnCardClickListener) : RecyclerView.Adapter<UserInviteAdapter.UserViewHolder>() {

    private var users: List<InviteCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
        return UserViewHolder(
                LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_project, parent, false )
        )
    }

    override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
        when(holder){
            is UserViewHolder ->{
                holder.bind(users.get(position),clickListener)
            }
        }
    }

    override fun getItemCount(): Int {
        return users.size
    }

    fun submitList(inviteCardList: List<InviteCard>){
        users=inviteCardList
    }

    class UserViewHolder  constructor(
            itemView: View
    ): RecyclerView.ViewHolder(itemView) {

        var name: TextView =itemView.nameTextView
        var secondary: TextView=itemView.secondaryTextView
        var support: TextView=itemView.supportTextView

        fun bind(invitecard : InviteCard, action:OnCardClickListener){
            name.setText(invitecard.Name )
            secondary.setText(invitecard.username)
            support.setText(invitecard.Expertise)

            //Listeners for each project cards
            itemView.buttonView.setOnClickListener {
                action.onViewButtonClick(invitecard,adapterPosition)
            }
            itemView.buttonEdit.setOnClickListener {
                action.onEditButtonClick(invitecard,adapterPosition)
            }

        }

    }
}