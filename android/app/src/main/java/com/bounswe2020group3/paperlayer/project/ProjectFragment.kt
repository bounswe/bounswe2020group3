package com.bounswe2020group3.paperlayer.project

import android.content.Context
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.data.Project
import kotlinx.android.synthetic.main.fragment_project.*
import kotlinx.android.synthetic.main.fragment_project.view.*
import java.io.Serializable
import javax.inject.Inject

private const val TAG = "ProjectFragment"

class ProjectFragment : Fragment(),ProjectContract.View {

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
        val view = inflater.inflate(R.layout.fragment_project, container, false)
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