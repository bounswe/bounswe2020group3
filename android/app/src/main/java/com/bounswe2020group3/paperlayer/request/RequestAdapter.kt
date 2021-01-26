package com.bounswe2020group3.paperlayer.request

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.squareup.picasso.Picasso

interface RequestListener {
    fun onAcceptButtonClick(item: RequestItem, position: Int)
    fun onRejectButtonClick(item: RequestItem, position: Int)
    fun onItemClick(item: RequestItem, position: Int)

}

class RequestAdapter(var clickListener: RequestListener) :
    RecyclerView.Adapter<RequestAdapter.RequestViewHolder>() {
    private var requestList: List<RequestItem> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RequestViewHolder {
        return RequestViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.layout_list_item_request, parent, false)
        )
    }

    override fun onBindViewHolder(holder: RequestViewHolder, position: Int) {
        holder.bind(requestList[position], clickListener)
    }

    override fun getItemCount(): Int {
        return requestList.size
    }

    fun submitList(requestList: List<RequestItem>) {
        this.requestList = requestList
    }

    class RequestViewHolder(val itemView: View) : RecyclerView.ViewHolder(itemView) {

        private val fullName: TextView = itemView.findViewById(R.id.textViewNameSurname)
        private val accept: Button = itemView.findViewById(R.id.buttonCollabRequestAccept)
        private val reject: Button = itemView.findViewById(R.id.buttonCollabRequestReject)
        private val avatar: ImageView = itemView.findViewById(R.id.imageViewCollabRequestAvatar)

        fun bind(item: RequestItem, action: RequestListener) {
            fullName.text = item.fullName

            // Retrieve profile picture and display in avatar
            val imageUrl = item.photoUrl
            if (imageUrl != "") {
                Picasso.get().load(imageUrl).into(avatar)
            } else {
                avatar.setImageResource(R.drawable.ic_avatar)
            }

            accept.setOnClickListener {
                action.onAcceptButtonClick(item, adapterPosition)
            }
            reject.setOnClickListener {
                action.onRejectButtonClick(item, adapterPosition)
            }

            itemView.setOnClickListener {
                action.onItemClick(item, adapterPosition)
            }
        }

    }
}