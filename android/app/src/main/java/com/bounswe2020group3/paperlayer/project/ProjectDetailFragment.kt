package com.bounswe2020group3.paperlayer.project

import android.content.Context
import android.graphics.Color
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.View.GONE
import android.view.ViewGroup
import android.widget.Toast
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.data.Project
import com.google.android.material.chip.Chip
import com.google.android.material.tabs.TabLayout
import kotlinx.android.synthetic.main.fragment_project_detail.*
import kotlinx.android.synthetic.main.fragment_project_detail.view.*
import javax.inject.Inject

private const val TAG = "ProjectFragment"


//val tagColors = arrayOf("#D2B4DE", "#F8C471", "#76D7C4", "#AED6F1", "#DAF7A6", "#FA8072", "#FEC8D8", "#85EE85", "#FDFD96", "#89AED8")
val tagColors = arrayOf(R.color.tagColor0, R.color.tagColor1, R.color.tagColor2,R.color.tagColor3,R.color.tagColor4,R.color.tagColor5,R.color.tagColor6,R.color.tagColor7,R.color.tagColor8,R.color.tagColor9)


class ProjectDetailFragment : Fragment(),ProjectDetailContract.View {

    //Presenter object
    @Inject
    lateinit var presenter: ProjectPresenter

    //View object
    private lateinit var fragmentView: View

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        this.presenter.unbind()
        writeLogMessage("i",TAG,"ProjectFragment destroyed.")
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_project_detail, container, false)
        this.fragmentView=view
        //Set ProjectPresenter view to project fragment
        this.presenter.setView(this)
        this.presenter.bind(this)
        //Getting bundle arguments
        var projectID = arguments?.getInt("projectID")
        if (projectID != null) {
            this.presenter.fetchProject(projectID) //fetch project and update ui
        }
        else{
            writeLogMessage("e",TAG,"projectID null")
        }
        writeLogMessage("i",TAG,"ProjectFragment view created")
        return view
    }

    override fun getLayout(): View {
        return this.fragmentView
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun writeLogMessage(type:String ,tag: String,message: String) {
        when(type){
            "e"-> Log.e(tag,message) //error
            "w"-> Log.w(tag,message) //warning
            "i"-> Log.i(tag,message) //information
            "d"-> Log.d(tag,message) //debug
            "v"-> Log.v(tag,message) //verbose
            else->Log.e(tag,"Type is not defined")
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        tabLayoutProject.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener{
            override fun onTabSelected(tab: TabLayout.Tab?) {
                when (tab?.position) {
                    0 -> {
                        linearLayoutProperties.visibility = View.VISIBLE
                        linearLayoutMembers.visibility = View.GONE
                    }
                    1 -> {
                        linearLayoutProperties.visibility = View.GONE
                        linearLayoutMembers.visibility = View.VISIBLE
                    }
                }
            }

            override fun onTabUnselected(tab: TabLayout.Tab?) = Unit

            override fun onTabReselected(tab: TabLayout.Tab?) = Unit

        })
        buttonEditProject.setOnClickListener {
            presenter.navigateToEditProject()
        }
    }

    //Update project UI
    override fun updateProjectUI(project: Project) {
        val tab = this.fragmentView.tabLayoutProject.getTabAt(1)
        val badge=tab?.orCreateBadge
        badge?.maxCharacterCount=2
        badge?.number=10

        this.fragmentView.projectTitle.text=project.name
        this.fragmentView.projectDescription.text=project.description
        this.fragmentView.projectOwner.text=project.owner
        this.fragmentView.projectType.text=project.project_type
        this.fragmentView.projectDue.text=project.due_date
        this.fragmentView.projectState.text=project.state
        if(project.event!=null)
        {
            this.fragmentView.textViewEvents.text=project.event.title
        }


        //Tag Field Text
        if(project.tags.isEmpty()) {
            this.fragmentView.textViewTags.text="There is no tags in this project. You can add tags to project from project edit page."
        }
        else{
            this.fragmentView.textViewTags.visibility=GONE
        }
        //Adding tags to dynamically to project tags
        for (tag in project.tags){
            val chip = Chip(this.fragmentView.chipGroupTags.context)
            chip.text=tag.name
            chip.setChipBackgroundColorResource(tagColors[tag.color])
            this.fragmentView.chipGroupTags.addView(chip)
        }

        writeLogMessage("i",TAG,"Project UI Updated")
    }

    //Reset project UI
    override fun resetProjectUI() {
        this.fragmentView.projectTitle.text="Example Project"
        this.fragmentView.projectDescription.text="Example Description"
        this.fragmentView.projectOwner.text="Example Owner"
        this.fragmentView.projectType.text="Example Type"
        this.fragmentView.projectDue.text="Example Date"
        this.fragmentView.projectState.text="Example State"
        writeLogMessage("i",TAG,"Project UI Reset")
    }

}