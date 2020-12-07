package com.bounswe2020group3.paperlayer.invite


import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.layout_list_item_userinvites.view.*

private const val TAG = "InviteAdapter"

//Interface to communicate between fragment and recyclerview items
interface OnCardClickListener{
    fun onInviteButtonClick(item: InviteCard, position: Int )
}


class UserInviteAdapter(var clickListener: OnCardClickListener) : RecyclerView.Adapter<UserInviteAdapter.UserViewHolder>() {

    private var users: List<InviteCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
        return UserViewHolder(
                LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_userinvites, parent, false )
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

        var name: TextView =itemView.findViewById(R.id.nameTextView)
        var secondary: TextView=itemView.findViewById(R.id.secondaryTextView)
        var support: TextView=itemView.findViewById(R.id.supportTextView)

        fun bind(invitecard : InviteCard, action:OnCardClickListener){
            name.setText(invitecard.Name )
            secondary.setText(invitecard.username)
            support.setText(invitecard.Expertise)

            //Listeners for each project cards
            itemView.buttonInvite.setOnClickListener {
                action.onInviteButtonClick(invitecard,adapterPosition)
            }


        }

    }
}