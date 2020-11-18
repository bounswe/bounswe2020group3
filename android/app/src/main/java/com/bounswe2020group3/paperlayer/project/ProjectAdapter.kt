package com.bounswe2020group3.paperlayer.project

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.layout_list_item_project.view.*




class ProjectAdapter : RecyclerView.Adapter<ProjectAdapter.ProjectViewHolder>() {

    private var projects: List<ProjectCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ProjectViewHolder {
        return ProjectViewHolder(
            LayoutInflater.from(parent.context).inflate(R.layout.layout_list_item_project, parent, false )
        )
    }

    override fun onBindViewHolder(holder: ProjectViewHolder, position: Int) {
        when(holder){

            is ProjectViewHolder ->{
                holder.bind(projects.get(position))
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
        val projectTitle=itemView.textViewProjectTitle
        val projectDescription=itemView.textViewProjectDescription
        val projectCreator=itemView.textViewProjectCreator


        fun bind(projectCard: ProjectCard){
            projectTitle.setText(projectCard.projectTitle)
            projectDescription.setText(projectCard.projectBody)
            projectCreator.setText(projectCard.projectCreator)
        }

    }
}