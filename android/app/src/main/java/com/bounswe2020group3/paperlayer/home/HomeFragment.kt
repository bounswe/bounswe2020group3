package com.bounswe2020group3.paperlayer.home

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.home.adaptors.EventAdaptor
import com.bounswe2020group3.paperlayer.home.cards.EventCard
import dagger.Binds
import javax.inject.Inject

private const val TAG = "HomeFragment"

class HomeFragment : Fragment(), HomeContract.View {

    @Inject
    lateinit var presenter : HomePresenter
    lateinit var fragment_view : View
    private lateinit var mContext: Context

    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdapter: EventAdaptor
    private lateinit var viewManager: RecyclerView.LayoutManager

    private val eventCardsList = ArrayList<EventCard>()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val view = inflater.inflate(R.layout.fragment_home, container, false)
        fragment_view = view
        initRecycler()
        writeLogMessage("i",TAG,"home fragment has been created.")
        return view
    }
    fun initRecycler(){
        viewManager = LinearLayoutManager(this.context)
        viewAdapter = EventAdaptor()

        /*setHasFixedSize(true):Bu özelliği set ettiğimizde
        performansı arttırır. Eğer içeriğin değişmesi, RecyclerView
        düzen boyutunu değiştirmiyorsa bu özelliği set edebilirsiniz.

        layoutManager: Her bir satırın nasıl hizalanacağı belirlenir.
        Her satır dikey olarak hizalanır.

        adapter: RecyclerView, adapter ile doldurulur.*/
        recyclerView = fragment_view.findViewById<RecyclerView>(R.id.recyclerViewEvents).apply{
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = viewAdapter
        }

        test()

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

    override fun addEventCard(card : EventCard){
        eventCardsList.add(card)
        writeLogMessage("i", TAG,"Project Card Added ${card.title} ")

    }
    override fun resetEventCardList() {
        eventCardsList.clear()
        viewAdapter.submitList(this.eventCardsList)
        viewAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun submitEventCardList() {
        viewAdapter.submitList(this.eventCardsList)
        viewAdapter.notifyDataSetChanged() //notify to update recyclerview
        writeLogMessage("i", TAG,"Project Card List Updated! " + eventCardsList.size)
    }
    fun test(){
        addEventCard(EventCard("a","a","a","a","a","a"))
        addEventCard(EventCard("b","b","b","b","b","b"))
        addEventCard(EventCard("c","c","c","c","c","c"))
        submitEventCardList()

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
    }
    override fun onDestroy() {
        super.onDestroy()

    }
}