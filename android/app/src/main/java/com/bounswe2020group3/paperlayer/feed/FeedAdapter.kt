package com.bounswe2020group3.paperlayer.feed

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.feed.data.Feed
import com.bounswe2020group3.paperlayer.feed.data.FeedType


class FeedAdapter(var feedItems: List<Feed>): RecyclerView.Adapter<FeedAdapter.FeedViewHolder>() {
    var onFeedItemClick: ((Feed) -> Unit)? = null
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FeedAdapter.FeedViewHolder {
        val itemView = LayoutInflater.from(parent.context)
            .inflate(R.layout.layout_list_item_feed, parent, false)
        return FeedViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: FeedAdapter.FeedViewHolder, position: Int) {
        holder.bind(feedItems[position])
    }

    override fun getItemCount(): Int {
        return feedItems.size
    }

    inner class FeedViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {
        private var feedInformation: TextView = itemView.findViewById(R.id.textViewItem)
        init {
            itemView.setOnClickListener {
                onFeedItemClick?.invoke(feedItems[adapterPosition])
            }
        }

        fun bind(feed: Feed) {
            when ( feed.feedType) {
                FeedType.EVENT -> {
                    feedInformation.text = "${feed.verb}"
                }
                else -> {
                    feedInformation.text = "${feed.actor} ${feed.verb}"
                }
            }
        }
    }
}