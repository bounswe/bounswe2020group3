package com.bounswe2020group3.paperlayer.invite

import com.bounswe2020group3.paperlayer.project.ProjectCard



import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.layout_list_item_project.view.*

//Interface to communicate between fragment and recyclerview items
interface OnCardClickListener{
    fun onViewButtonClick(item: ProjectCard, position: Int )
    fun onEditButtonClick(item: ProjectCard, position: Int )
}


class ProjectAdapter(var clickListener: OnCardClickListener) : RecyclerView.Adapter<ProjectAdapter.ProjectViewHolder>() {

    private var projects: List<ProjectCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ProjectViewHolder {
        return ProjectViewHolder(
                LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_project, parent, false )
        )
    }

    override fun onBindViewHolder(holder: ProjectViewHolder, position: Int) {
        when(holder){
            is ProjectViewHolder ->{
                holder.bind(projects.get(position),clickListener)
            }
        }
    }

    override fun getItemCount(): Int {
        return projects.size
    }

    fun submitList(projectCardList: List<ProjectCard>){
        projects=projectCardList
    }

    class ProjectViewHolder  constructor(
            itemView: View
    ): RecyclerView.ViewHolder(itemView) {

        var projectTitle: TextView =itemView.textViewProjectTitle
        var projectDescription: TextView=itemView.textViewProjectDescription
        var projectCreator: TextView=itemView.textViewProjectCreator

        fun bind(projectCard: ProjectCard, action:OnCardClickListener){
            projectTitle.setText(projectCard.projectTitle)
            projectDescription.setText(projectCard.projectBody)
            projectCreator.setText("@"+projectCard.projectCreator)

            //Listeners for each project cards
            itemView.buttonView.setOnClickListener {
                action.onViewButtonClick(projectCard,adapterPosition)
            }
            itemView.buttonEdit.setOnClickListener {
                action.onEditButtonClick(projectCard,adapterPosition)
            }

        }

    }
}