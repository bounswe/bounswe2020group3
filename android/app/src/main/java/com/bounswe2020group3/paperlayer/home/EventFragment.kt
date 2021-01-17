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
import com.bounswe2020group3.paperlayer.home.adaptors.EventAdaptor
import com.bounswe2020group3.paperlayer.home.adaptors.OnCardClickListenerForEvents
import com.bounswe2020group3.paperlayer.home.cards.EventCard
import com.google.android.material.bottomnavigation.BottomNavigationView
import javax.inject.Inject

private const val TAG = "EventFragment"

class EventFragment : Fragment(), HomeContract.EventView, OnCardClickListenerForEvents {

    @Inject
    lateinit var presenter : EventPresenter

    lateinit var fragment_view : View
    private lateinit var mContext: Context

    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdapter: EventAdaptor
    private lateinit var viewManager: RecyclerView.LayoutManager

    private val eventCardsList = ArrayList<EventCard>()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val view = inflater.inflate(R.layout.fragment_events, container, false)
        this.fragment_view = view
        initRecycler()
        this.presenter.bind(this)
        resetCardList()
        writeLogMessage("i",TAG,"event fragment has been created.")
        view.findViewById<BottomNavigationView>(R.id.bottomNavigationView).setOnNavigationItemSelectedListener { item ->
            when(item.itemId){
                R.id.eventFragment ->{}
                R.id.projectUpdateFragment ->{
                    Navigation.findNavController(view).navigate(R.id.navigateToProjectUpdatesFromEvents)}
                R.id.milestoneFragment ->{Navigation.findNavController(view).navigate(R.id.navigateToMilestonesFromEvents)}

            }
            true
        }

        return view
    }
    fun initRecycler(){
        viewManager = LinearLayoutManager(this.context)
        viewAdapter = EventAdaptor(this)


        recyclerView = fragment_view.findViewById<RecyclerView>(R.id.recyclerViewEvents).apply{
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = viewAdapter
        }

        //test()

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

    override fun addCard(card : EventCard){
        eventCardsList.add(card)
        writeLogMessage("i", TAG,"Project Card Added ${card.title} ")

    }
    override fun resetCardList() {
        eventCardsList.clear()
        viewAdapter.submitList(this.eventCardsList)
        viewAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun submitCardList() {
        viewAdapter.submitList(this.eventCardsList)
        viewAdapter.notifyDataSetChanged() //notify to update recyclerview
        writeLogMessage("i", TAG,"Project Card List Updated! " + eventCardsList.size)
    }

    override fun getLayout(): View {
        TODO("Not yet implemented")
    }

    override fun showToast(message: String) {
        TODO("Not yet implemented")
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
        mContext=context
        context.showBottomNav()
    }
    override fun onDestroy() {
        super.onDestroy()
        resetCardList()
        this.presenter.unbind()

    }

    override fun onCardClick(item: EventCard, position: Int) {
        val bundle = bundleOf("eventID" to item.id )

        Navigation.findNavController(fragment_view).navigate(R.id.navigateToEventDetailFromEvents,bundle)
    }
}