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
import com.squareup.picasso.Picasso

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

        val fullname: TextView =itemView.findViewById<TextView>(R.id.textViewNameSurname)
        val accept: Button =itemView.findViewById<Button>(R.id.buttonCollabRequestAccept)
        val reject: Button =itemView.findViewById<Button>(R.id.buttonCollabRequestReject)
        val avatar: ImageView =itemView.findViewById<ImageView>(R.id.imageViewCollabRequestAvatar)

        fun bind(item : CollabCard, action: OnCardClickListener){
            fullname.text = item.fullName

            //profile pic retrieve
            val imageUrl = item.photourl
            if (imageUrl != "") {
                Picasso.get().load(imageUrl).into(avatar)
            }

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