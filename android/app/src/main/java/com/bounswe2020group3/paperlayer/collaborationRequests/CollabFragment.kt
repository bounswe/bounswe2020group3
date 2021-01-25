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
import com.bounswe2020group3.paperlayer.request.RequestAdapter
import com.bounswe2020group3.paperlayer.request.RequestItem
import com.bounswe2020group3.paperlayer.request.RequestListener
import javax.inject.Inject

private const val TAG = "CollabFragment"

class CollabFragment : Fragment(), CollabContract.CollabView, RequestListener {

    @Inject
    lateinit var presenter: CollabPresenter

    private lateinit var fragmentView: View
    private lateinit var mContext: Context

    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdapter: RequestAdapter
    private lateinit var viewManager: RecyclerView.LayoutManager

    private val requestList = ArrayList<RequestItem>()
    override var projectId: Int = -1;

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        projectId = arguments?.getInt("projectID")!!
        writeLogMessage("i", TAG, "$projectId 's reqs")
        val view = inflater.inflate(R.layout.fragment_collaboration_requests, container, false)
        fragmentView = view
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        this.presenter.bind(this)
        initRecyclerView()
        resetItemList()
    }

    override fun getLayout(): View {
        TODO("Not yet implemented")
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    private fun initRecyclerView() {
        viewManager = LinearLayoutManager(this.context)
        viewAdapter = RequestAdapter(this)
        recyclerView = fragmentView.findViewById<RecyclerView>(R.id.recyclerViewCollabs).apply {
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = viewAdapter
        }


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

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
        mContext = context
    }

    override fun resetItemList() {
        requestList.clear()
        viewAdapter.submitList(this.requestList)
        viewAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun submitItemList() {
        viewAdapter.submitList(this.requestList)
        viewAdapter.notifyDataSetChanged() //notify to update recyclerview
        writeLogMessage("i", TAG, "Project Item List Updated! " + requestList.size)
    }

    override fun addItem(card: RequestItem) {
        requestList.add(card)
        writeLogMessage("i", TAG, "Addeddededed " + card)
    }

    override fun onAcceptButtonClick(item: RequestItem, position: Int) {
        presenter.onAcceptButtonClick(item, position)
    }

    override fun onRejectButtonClick(item: RequestItem, position: Int) {
        presenter.onRejectButtonClick(item, position)
    }

    override fun onItemClick(item: RequestItem, position: Int) {
        val bundle = bundleOf("userID" to item.userId)
        Navigation.findNavController(fragmentView).navigate(R.id.navigateToUserFromCollabs, bundle)
    }

    override fun removeItem(item: RequestItem) {
        if (requestList.remove(item))
            writeLogMessage("i", TAG, "Removal from the list is successful for item $item")
    }
}