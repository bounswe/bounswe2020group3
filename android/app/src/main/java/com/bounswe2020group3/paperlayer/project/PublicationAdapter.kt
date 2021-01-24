package com.bounswe2020group3.paperlayer.project

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
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

        var projectTitle: TextView =itemView.textViewProjectTitle
        var projectDescription: TextView =itemView.textViewProjectDescription
        var projectCreator: TextView =itemView.textViewProjectCreator

        fun bind(projectCard: ProjectCard,action:OnCardPublicationClickListener){
            projectTitle.setText(projectCard.projectTitle)
            projectDescription.setText(projectCard.projectBody)
            projectCreator.setText("@"+projectCard.projectCreator)


            //Listeners for each project cards
            itemView.buttonView.setOnClickListener {
                action.onViewPublicationButtonClick(projectCard,adapterPosition)
            }

        }

    }

}