package com.bounswe2020group3.paperlayer.project

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.View.*
import android.view.ViewGroup
import android.widget.Toast
import androidx.annotation.VisibleForTesting
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.data.Tag
import com.google.android.material.tabs.TabLayout
import kotlinx.android.synthetic.main.fragment_projects.*
import kotlinx.android.synthetic.main.fragment_projects.view.*
import kotlinx.android.synthetic.main.fragment_search.*
import javax.inject.Inject


private const val TAG = "ProjectMainFragment"

class ProjectsFragment : Fragment(), ProjectsContract.View, OnCardClickListener,OnCardPublicationClickListener {

    //Presenter object
    @Inject
    lateinit var presenter: ProjectMainPresenter

    //View object
    private lateinit var fragmentView: View

    //Adapter Object
    private lateinit var projectAdapter: ProjectAdapter
    private lateinit var publicationAdapter: PublicationAdapter

    // Declare Context variable at class level in Fragment
    private lateinit var mContext: Context
    private lateinit var recyclerView: RecyclerView
    private lateinit var recyclerViewPublications: RecyclerView

    //Project Card List
    private val projectCardList = ArrayList<ProjectCard>()

    //Publications Card List
    private val publicationsCardList = ArrayList<ProjectCard>()


    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
        mContext = context
    }

    override fun onDestroy() {
        super.onDestroy()
        resetProjectCardList()
        resetPublicationCardList()
        this.presenter.unbind()
        writeLogMessage("i", TAG, "ProjectMainFragment destroyed.")
    }

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_projects, container, false)
        this.fragmentView = view
        writeLogMessage("i", TAG, "ProjectMainFragment view created")
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initRecyclerView()
        resetProjectCardList()
        resetPublicationCardList()
        this.presenter.bind(this)

        buttonAddProject.setOnClickListener {
            presenter.onNewProjectButtonClicked()
        }

        buttonConnectScholar.setOnClickListener {
            presenter.connectScholarPublications(this.fragmentView.editTextScholarID.editText?.text.toString())
        }

        //Tab layout listener
        tabLayoutProjectsAndPublications!!.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab) {
                if(tab.position==0){//Projects tab selected
                    fragmentView.recyclerViewProjects.visibility=VISIBLE
                    fragmentView.recyclerViewPublications.visibility= GONE
                    fragmentView.buttonAddProject.visibility= VISIBLE
                    fragmentView.editTextScholarID.visibility=GONE
                    fragmentView.buttonConnectScholar.visibility=GONE
                    if(projectCardList.size==0){
                        showToast("You can add projects from create project icon.")
                    }
                }
                else{
                    fragmentView.recyclerViewProjects.visibility= GONE
                    fragmentView.recyclerViewPublications.visibility= VISIBLE
                    fragmentView.buttonAddProject.visibility= GONE

                    if(publicationsCardList.size==0){
                        showToast("Please connect your scholar id.")
                        showPublicationAdd()
                    }
                }

            }
            override fun onTabUnselected(tab: TabLayout.Tab) {

            }
            override fun onTabReselected(tab: TabLayout.Tab) {

            }
        })


    }

    override fun getLayout(): View {
        return this.fragmentView
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun writeLogMessage(type: String, tag: String, message: String) {
        when (type) {
            "e" -> Log.e(tag, message) //error
            "w" -> Log.w(tag, message) //warning
            "i" -> Log.i(tag, message) //information
            "d" -> Log.d(tag, message) //debug
            "v" -> Log.v(tag, message) //verbose
            else -> Log.e(tag, "Type is not defined")
        }
    }


    override fun resetProjectCardList() {
        projectCardList.clear()
        projectAdapter.submitList(this.projectCardList)
        projectAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun submitProjectCardList() {
        projectAdapter.submitList(this.projectCardList)
        projectAdapter.notifyDataSetChanged() //notify to update recyclerview
        writeLogMessage("i", TAG, "Project Card List Updated! " + projectCardList.size)
    }

    override fun addProjectCard(projectName: String, projectBody: String, projectOwner: String, projectId: Int, tags: List<Tag>,projectType: String) {
        projectCardList.add(
                ProjectCard(projectName,
                        projectBody,
                        projectOwner, projectId, tags,projectType))
        writeLogMessage("i", TAG, "Project Card Added $projectName ")
    }

    override fun resetPublicationCardList() {
        publicationsCardList.clear()
        publicationAdapter.submitList(this.publicationsCardList)
        publicationAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun submitPublicationCardList() {
        publicationAdapter.submitList(this.publicationsCardList)
        publicationAdapter.notifyDataSetChanged() //notify to update recyclerview
        writeLogMessage("i", TAG, "Publication Card List Updated! " + publicationsCardList.size)
    }

    override fun addPublicationCard(publicationTitle: String, publicationAbstract: String, publicationAuthors: String, tags: List<Tag>,publicationID: Int) {
        publicationsCardList.add(
                ProjectCard(publicationTitle,
                        publicationAbstract,
                        publicationAuthors, publicationID,tags,"Publication"))
        writeLogMessage("i", TAG, "Publication Card Added $publicationTitle ")
    }

    private fun initRecyclerView() {
        this.recyclerView = fragmentView.findViewById(R.id.recyclerViewProjects)!!
        this.recyclerView.layoutManager = LinearLayoutManager(this.context)
        this.projectAdapter = ProjectAdapter(this)
        this.recyclerView.adapter = projectAdapter

        this.recyclerViewPublications=fragmentView.findViewById(R.id.recyclerViewPublications)!!
        this.recyclerViewPublications.layoutManager=LinearLayoutManager(this.context)
        this.publicationAdapter= PublicationAdapter(this)
        this.recyclerViewPublications.adapter=publicationAdapter

        writeLogMessage("i", TAG, "RecyclerView initialized.")
    }

    override fun onViewButtonClick(item: ProjectCard, position: Int) {
        this.presenter.onViewProjectButtonClicked(item, position)
    }

    override fun onEditButtonClick(item: ProjectCard, position: Int) {
        this.presenter.onEditProjectButtonClicked(item, position)
    }

    override fun onViewPublicationButtonClick(item: ProjectCard, position: Int) {
        this.presenter.onViewPublicationButtonClicked(item,position)
    }

    override fun getMyContext(): Context {
        return this.mContext
    }

    override fun hidePublicationAdd(){
        fragmentView.editTextScholarID.visibility= GONE
        fragmentView.buttonConnectScholar.visibility=GONE
    }

    override fun showPublicationAdd(){
        fragmentView.editTextScholarID.visibility= VISIBLE
        fragmentView.buttonConnectScholar.visibility=VISIBLE
    }

}