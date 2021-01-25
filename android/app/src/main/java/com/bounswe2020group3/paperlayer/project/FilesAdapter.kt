package com.bounswe2020group3.paperlayer.project

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.layout_list_item_file.view.*
import kotlinx.android.synthetic.main.layout_list_item_project_member.view.*

interface OnFileCardClickListener {
    fun onCardClickListener(card: FileCard)
}

class FilesAdapter(val clickListener: OnFileCardClickListener): RecyclerView.Adapter<FilesAdapter.FileViewHolder>() {

    private var files: List<FileCard> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FilesAdapter.FileViewHolder {
        return FilesAdapter.FileViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.layout_list_item_file, parent, false)
        )
    }

    override fun onBindViewHolder(holder: FilesAdapter.FileViewHolder, position: Int) {
        when (holder) {
            is FilesAdapter.FileViewHolder -> {
                holder.bind(files.get(position), clickListener)
            }
        }
    }


    override fun getItemCount(): Int {
        return files.size
    }

    fun submitList(filesList: List<FileCard>) {
        files = filesList
    }

    class FileViewHolder constructor(
        itemView: View
    ) : RecyclerView.ViewHolder(itemView) {

        var fileName: TextView = itemView.textViewFileName
        var fileIcon: ImageView = itemView.imageViewFileIcon

        fun bind(filecard: FileCard, clickListener: OnFileCardClickListener) {
            fileName.text = filecard.fileName

            //ToDo file icon will be implemented

            itemView.setOnClickListener {
                clickListener.onCardClickListener(filecard)
            }
        }

    }
}
