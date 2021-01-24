package com.bounswe2020group3.paperlayer.invite


import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.squareup.picasso.Picasso

private const val TAG = "InviteAdapter"

//Interface to communicate between fragment and recyclerview items
interface OnCardClickListener {
    fun onInviteButtonClick(item: InviteCard, position: Int)
    fun onCardClick(userId: Int)
}

class UserInviteAdapter(var clickListener: OnCardClickListener) : RecyclerView.Adapter<UserInviteAdapter.UserViewHolder>() {

    private var users: List<InviteCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
        return UserViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_invite, parent, false)
        )
    }

    override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
        when (holder) {
            is UserViewHolder -> {
                holder.bind(users[position], clickListener)
            }
        }
    }

    override fun getItemCount(): Int {
        return users.size
    }

    fun submitList(inviteCardList: List<InviteCard>) {
        users = inviteCardList
    }

    class UserViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        private val inviteAvatar: ImageView = itemView.findViewById<ImageView>(R.id.imageViewInviteAvatar)
        val name: TextView = itemView.findViewById<TextView>(R.id.name)
        private val buttonInvite: Button = itemView.findViewById<Button>(R.id.inviteButton)

        fun bind(inviteCard: InviteCard, action: OnCardClickListener) {

            name.text = inviteCard.name

            val imageUrl = inviteCard.photo_url
            if (imageUrl != null && imageUrl != "") {
                Picasso.get().load(imageUrl).into(inviteAvatar)
            } else {
                inviteAvatar.setImageResource(R.drawable.ic_avatar)
            }

            itemView.setOnClickListener {
                action.onCardClick(inviteCard.userId)
            }

            Log.i(TAG, "${inviteCard.username} binded") //information

            //Listeners for each project cards
            buttonInvite.setOnClickListener {
                action.onInviteButtonClick(inviteCard, adapterPosition)
            }
            if (inviteCard.called)
                buttonInvite.text = "UNINVITE"
            else
                buttonInvite.text = "INVITE"
        }
    }
}