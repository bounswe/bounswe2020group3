package com.bounswe2020group3.paperlayer.home

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.home.adaptors.MilestoneAdaptor
import com.bounswe2020group3.paperlayer.home.adaptors.OnCardClickListenerForMilestones
import com.bounswe2020group3.paperlayer.home.cards.MilestoneCard
import com.google.android.material.bottomnavigation.BottomNavigationView
import javax.inject.Inject
private const val TAG = "MilestoneFragment"

class MilestoneFragment : Fragment(), HomeContract.MileStoneView , OnCardClickListenerForMilestones {


    @Inject
    lateinit var presenter : MilestonePresenter

    lateinit var fragment_view : View
    private lateinit var mContext: Context

    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdapter: MilestoneAdaptor
    private lateinit var viewManager: RecyclerView.LayoutManager

    private val milestoneCardsList = ArrayList<MilestoneCard>()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val view = inflater.inflate(R.layout.fragment_milestones, container, false)
        fragment_view = view

        initRecycler()
        resetCardList()

        this.presenter.bind(this)
        writeLogMessage("i",TAG,"event fragment has been created.")
        view.findViewById<BottomNavigationView>(R.id.bottomNavigationView).setOnNavigationItemSelectedListener { item ->
            when(item.itemId){
                R.id.eventFragment ->{        Navigation.findNavController(view).navigate(R.id.navigateToEventsFromMilestones)
                }
                R.id.recommendedProjectsFragment ->{Navigation.findNavController(view).navigate(R.id.navigateToProjectUpdatesFromMilestones)}
                R.id.milestoneFragment ->{}

            }
            true
        }
        return view
    }
    fun initRecycler(){
        viewManager = LinearLayoutManager(this.context)
        viewAdapter = MilestoneAdaptor(this)


        recyclerView = fragment_view.findViewById<RecyclerView>(R.id.recyclerViewMilestones).apply{
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = viewAdapter
        }

        //test()

    }
    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
        mContext=context
    }
    override fun onDestroy() {
        super.onDestroy()
        resetCardList()
        this.presenter.unbind()

    }

    override fun getLayout(): View {
        TODO("Not yet implemented")
    }

    override fun showToast(message: String) {
        TODO("Not yet implemented")
    }

    override fun writeLogMessage(type: String, tag: String, message: String) {
        when(type){
            "e"-> Log.e(tag,message) //error
            "w"-> Log.w(tag,message) //warning
            "i"-> Log.i(tag,message) //information
            "d"-> Log.d(tag,message) //debug
            "v"-> Log.v(tag,message) //verbose
            else-> Log.e(tag,"Type is not defined")
        }
    }

    override fun onViewButtonClick(item: MilestoneCard, position: Int) {
        val bundle = bundleOf("projectID" to item.projectId )

        Navigation.findNavController(fragment_view).navigate(R.id.navigateToProjectFromHomepageMilestones,bundle)
    }

    override fun resetCardList() {
        milestoneCardsList.clear()
        viewAdapter.submitList(this.milestoneCardsList)
        viewAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun submitCardList() {
        viewAdapter.submitList(this.milestoneCardsList)
        viewAdapter.notifyDataSetChanged() //notify to update recyclerview
        writeLogMessage("i", TAG,"Project Card List Updated! " + milestoneCardsList.size)    }

    override fun addCard(card: MilestoneCard) {
        milestoneCardsList.add(card)
        writeLogMessage("i", TAG,"Project Card Added ${card.projectTitle} ")    }
}