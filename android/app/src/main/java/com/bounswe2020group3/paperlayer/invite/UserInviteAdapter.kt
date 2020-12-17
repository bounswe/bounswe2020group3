package com.bounswe2020group3.paperlayer.invite


import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
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
        return UserViewHolder( LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_invite, parent, false )
        )
    }

    override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
        when(holder){
            is UserViewHolder ->{
                holder.bind(users[position],clickListener)
            }
        }
    }

    override fun getItemCount(): Int {
        return users.size
    }

    fun submitList(inviteCardList: List<InviteCard>){
        users=inviteCardList
    }

    class UserViewHolder(val itemView: View): RecyclerView.ViewHolder(itemView) {

        val username: TextView =itemView.findViewById<TextView>(R.id.username)
        val name: TextView=itemView.findViewById<TextView>(R.id.name)
        val expertise: TextView=itemView.findViewById<TextView>(R.id.expertise)
        val buttonInvite : Button = itemView.findViewById<Button>(R.id.inviteButton)

        fun bind(invitecard : InviteCard, action:OnCardClickListener){
            username.text = invitecard.username
            name.text = invitecard.name
            expertise.text = invitecard.expertise
            Log.i(TAG,"${invitecard.username} binded") //information
            //Listeners for each project cards
            buttonInvite.setOnClickListener {
                action.onInviteButtonClick(invitecard,adapterPosition)
            }
            if (invitecard.called)
            buttonInvite.setText("Uninvite")


        }

    }
}