package com.bounswe2020group3.paperlayer.project

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.login.LoginPresenter
import com.bounswe2020group3.paperlayer.main.MainPresenter
import kotlinx.android.synthetic.main.fragment_project_main.*


class ProjectMainFragment : Fragment(),ProjectMainContract.View, OnCardClickListener {


    //Presenter object
    private lateinit var presenter: ProjectMainPresenter
    //View object
    private lateinit var fragment_view: View
    //Adapter Object
    private lateinit var projectAdapter: ProjectAdapter

    // Declare Context variable at class level in Fragment
    private lateinit var mContext: Context
    private lateinit var recyclerView: RecyclerView



    /*
    * Creates LoginPresenter Object and setView
    * */
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        this.presenter= ProjectMainPresenter()
    }

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_project_main, container, false)

        this.fragment_view=view
        //this.recyclerView=fragment_view.recyclerViewProjects
        initRecyclerView()
        addProjectList()
        this.presenter.setView(this)
        this.presenter.created()
        return view
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        mContext=context
    }

    override fun initOnClicks() {
    }

    override fun getLayout(): View {
        return this.fragment_view
    }

    override fun resetEditText() {
    }

    fun addProjectList(){
        val projectCardList=ArrayList<ProjectCard>()
        projectCardList.add(
                ProjectCard("Covid19 Search",
                        "We are so close to developing vaccine for covid19",
                        "crazyDoctor",1))
        projectCardList.add(ProjectCard("Embedded System Class Research",
                "How to improve cmpe443 class before students make a riot",
                "crazyProf",2))
        projectCardList.add(ProjectCard("Eating Fruits affects performance in coding",
                "Research about how eating fruits while coding affects performance of programmers",
                "crazyCoder",3))

        projectAdapter.submitList(projectCardList)
    }

    private fun initRecyclerView(){
        recyclerView= fragment_view.findViewById(R.id.recyclerViewProjects)!!
        recyclerView.layoutManager=LinearLayoutManager(this.context)
        projectAdapter=ProjectAdapter(this)
        recyclerView.adapter=projectAdapter

        //recyclerView.apply {
          //  layoutManager=LinearLayoutManager(this.context)
            //projectAdapter=ProjectAdapter()
            //adapter=projectAdapter
       // }
        //alternative use
        //recyclerViewProjects.layoutManager=LinearLayoutManager(this.context)
        //this.projectAdapter= ProjectAdapter()
        //recyclerViewProjects.adapter=projectAdapter
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun onViewButtonClick(item: ProjectCard, position: Int) {
        showToast(item.projectTitle)
    }

    override fun onEditButtonClick(item: ProjectCard, position: Int) {
        var msg="Edit btn "+item.projectTitle
        showToast(msg)
    }

}