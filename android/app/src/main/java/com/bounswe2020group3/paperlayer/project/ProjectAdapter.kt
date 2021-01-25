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
import kotlinx.android.synthetic.main.layout_list_item_project.view.chip1
import kotlinx.android.synthetic.main.layout_list_item_project.view.chip2
import kotlinx.android.synthetic.main.layout_list_item_project.view.chip3

//Interface to communicate between fragment and recyclerview items
interface OnCardClickListener{
    fun onViewButtonClick(item: ProjectCard,position: Int )
    fun onEditButtonClick(item: ProjectCard,position: Int )
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
        var projectIcon: ImageView =itemView.imageViewProjectIcon
        var chipGroupTag: ChipGroup =itemView.chipGroupTags

        fun bind(projectCard: ProjectCard,action:OnCardClickListener){
            projectTitle.setText(projectCard.projectTitle)
            projectDescription.setText(projectCard.projectBody)
            projectCreator.setText("@"+projectCard.projectCreator)

            when(projectCard.projectType){
                "conference" -> projectIcon.setImageResource(R.drawable.ic_conference)
                "instutution" -> projectIcon.setImageResource(R.drawable.ic_institution)
                "journal" -> projectIcon.setImageResource(R.drawable.ic_journal)
                else -> {
                   projectIcon.setImageResource(R.drawable.ic_project)
                }

            }
            //Updating Tags
            when(projectCard.tags.size) {
                0 -> {
                    chipGroupTag.visibility = View.GONE
                }
                1 -> {
                    itemView.chip1.text = projectCard.tags[0].name
                    itemView.chip1.setChipBackgroundColorResource(tagColors[projectCard.tags[0].color])
                    itemView.chip2.visibility = View.INVISIBLE
                    itemView.chip3.visibility = View.INVISIBLE
                }
                2 -> {
                    itemView.chip1.text = projectCard.tags[0].name
                    itemView.chip1.setChipBackgroundColorResource(tagColors[projectCard.tags[0].color])
                    itemView.chip2.text = projectCard.tags[1].name
                    itemView.chip2.setChipBackgroundColorResource(tagColors[projectCard.tags[1].color])
                    itemView.chip3.visibility = View.INVISIBLE
                }
                3 -> {
                    itemView.chip1.text = projectCard.tags[0].name
                    itemView.chip1.setChipBackgroundColorResource(tagColors[projectCard.tags[0].color])
                    itemView.chip2.text = projectCard.tags[1].name
                    itemView.chip2.setChipBackgroundColorResource(tagColors[projectCard.tags[1].color])
                    itemView.chip3.text = projectCard.tags[2].name
                    itemView.chip3.setChipBackgroundColorResource(tagColors[projectCard.tags[2].color])
                }
                else -> {
                    itemView.chip1.text = projectCard.tags[0].name
                    itemView.chip1.setChipBackgroundColorResource(tagColors[projectCard.tags[0].color])
                    itemView.chip2.text = projectCard.tags[1].name
                    itemView.chip2.setChipBackgroundColorResource(tagColors[projectCard.tags[1].color])
                    itemView.chip3.text = projectCard.tags[2].name
                    itemView.chip3.setChipBackgroundColorResource(tagColors[projectCard.tags[2].color])
                }
            }


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