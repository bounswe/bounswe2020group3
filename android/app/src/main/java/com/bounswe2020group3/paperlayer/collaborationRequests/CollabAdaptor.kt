package com.bounswe2020group3.paperlayer.collaborationRequests

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.home.adaptors.ProjectAdaptor
import com.bounswe2020group3.paperlayer.home.cards.ProjectUpdateCard

interface OnCardClickListener{
    fun onAcceptButtonClick(item: CollabCard, position: Int )
    fun onRejectButtonClick(item: CollabCard, position: Int )
    fun onCardClick(item: CollabCard, position: Int )

}
class CollabAdaptor (var clickListener: OnCardClickListener) : RecyclerView.Adapter<CollabAdaptor.CollabViewHolder>() {
    private var collabs: List<CollabCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CollabViewHolder {
        return CollabAdaptor.CollabViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_collaborationrequest, parent, false))
    }

    override fun onBindViewHolder(holder: CollabViewHolder, position: Int) {
        when(holder){
            is CollabAdaptor.CollabViewHolder ->{
                holder.bind(collabs[position],clickListener)
            }
        }
    }

    override fun getItemCount(): Int {
        return collabs.size
    }
    fun submitList(collabList : List<CollabCard>){
        collabs=collabList
    }

    class CollabViewHolder(val itemView: View): RecyclerView.ViewHolder(itemView) {

        val username: TextView =itemView.findViewById<TextView>(R.id.textViewUsername)
        val expertise: TextView =itemView.findViewById<TextView>(R.id.textViewExpertise)
        val fullname: TextView =itemView.findViewById<TextView>(R.id.textViewNameSurname)
        val accept: ImageView =itemView.findViewById<ImageView>(R.id.imageViewAccept)
        val reject: ImageView =itemView.findViewById<ImageView>(R.id.imageViewReject)
        val profilePic : ImageView = itemView.findViewById<ImageView>(R.id.imageViewProfile)
        fun bind(item : CollabCard, action: OnCardClickListener){
            username.text = item.username
            expertise.text = item.expertise
            fullname.text = item.fullName
            //profile pic retrieve
            accept.setOnClickListener {
                action.onAcceptButtonClick(item,adapterPosition)
            }
            reject.setOnClickListener {
                action.onRejectButtonClick(item,adapterPosition)
            }
            itemView.setOnClickListener{
                action.onCardClick(item,adapterPosition)
            }



        }

    }
}