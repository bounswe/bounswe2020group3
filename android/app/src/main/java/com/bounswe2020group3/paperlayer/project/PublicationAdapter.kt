package com.bounswe2020group3.paperlayer.project

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.google.android.material.chip.ChipGroup
import kotlinx.android.synthetic.main.layout_list_item_project.view.*

//Interface to communicate between fragment and recyclerview items
interface OnCardPublicationClickListener{
    fun onViewPublicationButtonClick(item: ProjectCard,position: Int )
}

class PublicationAdapter(var clickListener: OnCardPublicationClickListener): RecyclerView.Adapter<PublicationAdapter.PublicationViewHolder>() {

    private var publications: List<ProjectCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PublicationAdapter.PublicationViewHolder {
        return PublicationAdapter.PublicationViewHolder(
                LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_project, parent, false)
        )
    }

    override fun onBindViewHolder(holder: PublicationAdapter.PublicationViewHolder, position: Int) {
        when(holder){
            is PublicationAdapter.PublicationViewHolder ->{
                holder.bind(publications.get(position),clickListener)
            }
        }
    }

    override fun getItemCount(): Int {
        return publications.size
    }

    fun submitList(publicationCardList: List<ProjectCard>){
        publications=publicationCardList
    }

    class PublicationViewHolder  constructor(
            itemView: View
    ): RecyclerView.ViewHolder(itemView) {

        var publicationTitle: TextView =itemView.textViewProjectTitle
        var publicationDescription: TextView =itemView.textViewProjectDescription
        var publicationCreator: TextView =itemView.textViewProjectCreator
        var publicationIcon: ImageView = itemView.imageViewProjectIcon
        var chipGroupTag: ChipGroup =itemView.chipGroupTags

        fun bind(projectCard: ProjectCard,action:OnCardPublicationClickListener){
            publicationTitle.setText(projectCard.projectTitle)
            publicationDescription.setText(projectCard.projectBody)
            publicationCreator.setText("Citation number: "+projectCard.projectCreator)
            publicationIcon.setImageResource(R.drawable.ic_journal)

            chipGroupTag.visibility = View.GONE

            //Listeners for each project cards
            itemView.buttonView.setOnClickListener {
                action.onViewPublicationButtonClick(projectCard,adapterPosition)
            }

        }

    }

}