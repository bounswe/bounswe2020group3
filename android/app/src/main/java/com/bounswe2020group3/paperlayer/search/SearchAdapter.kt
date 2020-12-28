package com.bounswe2020group3.paperlayer.search

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.View.*
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.tagColors
import com.google.android.material.chip.Chip
import com.google.android.material.chip.ChipGroup
import kotlinx.android.synthetic.main.fragment_project_detail.view.*
import kotlinx.android.synthetic.main.layout_list_item_search.view.*
import kotlinx.android.synthetic.main.layout_list_item_search.view.chipGroupTags


//Interface to communicate between fragment and recyclerview items
interface OnCardClickListener{
    fun onSearchCardClick(item: SearchCard, position: Int )
}

class SearchAdapter(var clickListener: OnCardClickListener): RecyclerView.Adapter<SearchAdapter.SearchViewHolder>() {

    private var searchResults: List<SearchCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SearchViewHolder {
        return SearchViewHolder(
                LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_search, parent, false)
        )
    }

    override fun onBindViewHolder(holder: SearchViewHolder, position: Int) {
        when(holder){
            is SearchViewHolder ->{
                holder.bind(searchResults.get(position),clickListener)
            }
        }
    }

    override fun getItemCount(): Int {
        return searchResults.size
    }

    fun submitList(searchCardList: List<SearchCard>){
        searchResults=searchCardList
    }

    class SearchViewHolder  constructor(
            itemView: View
    ): RecyclerView.ViewHolder(itemView) {

        var title: TextView =itemView.textViewTitle
        var body: TextView =itemView.textViewBody
        var supportText: TextView =itemView.textViewSupportText
        var titleIcon: ImageView =itemView.imageViewTitleIcon
        var chipGroupTag: ChipGroup =itemView.chipGroupTags

        fun bind(searchCard: SearchCard, action:OnCardClickListener){

            when(searchCard.searchType){
                0-> {//Project Search Results
                    title.text = searchCard.title
                    body.text = searchCard.body
                    supportText.text = "@"+searchCard.supportText

                    when(searchCard.titleIconType){
                        0 -> titleIcon.setImageResource(R.drawable.ic_conference) //conference
                        1 -> titleIcon.setImageResource(R.drawable.ic_institution) //institution
                        2 -> titleIcon.setImageResource(R.drawable.ic_journal) //journal
                        else -> {
                            titleIcon.setImageResource(R.drawable.ic_project) //default project
                        }
                    }
                    //Updating Tags
                    when(searchCard.tags.size){
                        0->{
                            chipGroupTag.visibility= GONE
                        }
                        1->{
                            itemView.chip1.text=searchCard.tags[0].name
                            itemView.chip1.setChipBackgroundColorResource(tagColors[searchCard.tags[0].color])
                            itemView.chip2.visibility= INVISIBLE
                            itemView.chip3.visibility= INVISIBLE
                        }
                        2->{
                            itemView.chip1.text=searchCard.tags[0].name
                            itemView.chip1.setChipBackgroundColorResource(tagColors[searchCard.tags[0].color])
                            itemView.chip2.text=searchCard.tags[1].name
                            itemView.chip2.setChipBackgroundColorResource(tagColors[searchCard.tags[1].color])
                            itemView.chip3.visibility= INVISIBLE
                        }
                        3->{
                            itemView.chip1.text=searchCard.tags[0].name
                            itemView.chip1.setChipBackgroundColorResource(tagColors[searchCard.tags[0].color])
                            itemView.chip2.text=searchCard.tags[1].name
                            itemView.chip2.setChipBackgroundColorResource(tagColors[searchCard.tags[1].color])
                            itemView.chip3.text=searchCard.tags[2].name
                            itemView.chip3.setChipBackgroundColorResource(tagColors[searchCard.tags[2].color])
                        }
                        else->{
                            itemView.chip1.text=searchCard.tags[0].name
                            itemView.chip1.setChipBackgroundColorResource(tagColors[searchCard.tags[0].color])
                            itemView.chip2.text=searchCard.tags[1].name
                            itemView.chip2.setChipBackgroundColorResource(tagColors[searchCard.tags[1].color])
                            itemView.chip3.text=searchCard.tags[2].name
                            itemView.chip3.setChipBackgroundColorResource(tagColors[searchCard.tags[2].color])
                        }
                    }
                }

                1->{//User Search Results
                    title.text = searchCard.title //User name
                    body.visibility=GONE
                    supportText.visibility= GONE
                    titleIcon.setImageResource(R.drawable.ic_avatar) //Default user icon
                    chipGroupTag.visibility=GONE
                }
                2->{//Event Search Results
                    title.text = searchCard.title //Event Name
                    body.text=searchCard.body //Location Text
                    supportText.visibility= GONE
                    titleIcon.setImageResource(R.drawable.ic_event)
                    chipGroupTag.visibility=GONE
                }
            }

            //Listeners for each search card
            itemView.setOnClickListener {
                action.onSearchCardClick(searchCard,adapterPosition)
            }
        }//End of bind
    }//End of Search View Holder

}