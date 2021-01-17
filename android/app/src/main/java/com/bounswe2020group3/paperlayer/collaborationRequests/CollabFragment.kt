package com.bounswe2020group3.paperlayer.collaborationRequests

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import javax.inject.Inject

private const val TAG = "CollabFragment"

class CollabFragment : Fragment(), CollabContract.CollabView, OnCardClickListener{

    @Inject
    lateinit var presenter : CollabPresenter

    lateinit var fragment_view : View
    private lateinit var mContext: Context

    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdaptor: CollabAdaptor
    private lateinit var viewManager: RecyclerView.LayoutManager

    private val collabsList = ArrayList<CollabCard>()
    override var projectId : Int = -1;

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        projectId = arguments?.getInt("projectID")!!
        writeLogMessage("i",TAG,"$projectId 's reqs")
        val view = inflater.inflate(R.layout.fragment_collaboration_requests, container, false)
        fragment_view = view


        this.presenter.bind(this)
        initRecyclerView()
        resetCardList()
        return view
    }

    override fun getLayout(): View {
        TODO("Not yet implemented")
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }
    private fun initRecyclerView(){
        viewManager = LinearLayoutManager(this.context)
        viewAdaptor= CollabAdaptor(this)
        recyclerView = fragment_view.findViewById<RecyclerView>(R.id.recyclerViewCollabs).apply{
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = viewAdaptor
        }


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

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
        mContext=context
    }

    override fun resetCardList() {

        collabsList.clear()
        viewAdaptor.submitList(this.collabsList)
        viewAdaptor.notifyDataSetChanged() //notify to update recyclerview

        }

    override fun submitCardList() {

        viewAdaptor.submitList(this.collabsList)
        viewAdaptor.notifyDataSetChanged() //notify to update recyclerview
        writeLogMessage("i", TAG,"Project Card List Updated! " + collabsList.size)      }

    override fun addCard(card: CollabCard) {
        collabsList.add(card)
        writeLogMessage("i", TAG,"Addeddededed " + card)
    }



    override fun onAcceptButtonClick(item: CollabCard, position: Int) {
        presenter.onAcceptButtonClick(item,position)
    }

    override fun onRejectButtonClick(item: CollabCard, position: Int) {
        presenter.onRejectButtonClick(item,position)
    }

    override fun onCardClick(item: CollabCard, position: Int) {
        val bundle = bundleOf("userID" to item.userid )

        Navigation.findNavController(fragment_view).navigate(R.id.navigateToUserFromCollabs,bundle)
    }

    override fun removeCard(card: CollabCard) {

        if(collabsList.remove(card))
            writeLogMessage("i",TAG,"removal from the list is successfull for card $card")
    }
}