package com.bounswe2020group3.paperlayer.project

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.login.ProjectMainPresenter
import kotlinx.android.synthetic.main.fragment_project_main.*
import kotlinx.android.synthetic.main.fragment_project_main.view.*


class ProjectMainFragment : Fragment(),ProjectMainContract.View {


    //Presenter object
    private lateinit var presenter: ProjectMainPresenter
    //View object
    private lateinit var fragment_view: View

    //private lateinit var recyclerView: RecyclerView

    private lateinit var projectAdapter: ProjectAdapter

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

    override fun initOnClicks() {
        TODO("Not yet implemented")
    }

    override fun getLayout(): View {
        return this.fragment_view
    }

    override fun resetEditText() {
        TODO("Not yet implemented")
    }

    fun addProjectList(){
        val projectCardList=ArrayList<ProjectCard>()
        projectCardList.add(
            ProjectCard("Covid19 Search",
            "We are so close to developing vaccine for covid19",
            "crazyDoctor"))
        projectCardList.add(ProjectCard("Embedded System Class Research",
            "How to improve cmpe443 class before students make a riot",
            "crazyProf"))
        projectCardList.add(ProjectCard("Eating Fruits affects performance in coding",
            "Research about how eating fruits while coding affects performance of programmers",
            "crazyCoder"))




        projectAdapter.submitList(projectCardList)
    }

    private fun initRecyclerView(){
        recyclerViewProjects.apply {
            layoutManager=LinearLayoutManager(this.context)
            projectAdapter=ProjectAdapter()
            adapter=projectAdapter
        }
        //alternative use
        //recyclerViewProjects.layoutManager=LinearLayoutManager(this.context)
        //this.projectAdapter= ProjectAdapter()
        //recyclerViewProjects.adapter=projectAdapter
    }

}