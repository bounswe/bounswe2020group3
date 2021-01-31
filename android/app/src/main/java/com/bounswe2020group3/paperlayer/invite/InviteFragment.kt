package com.bounswe2020group3.paperlayer.invite

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R

import javax.inject.Inject

private const val TAG = "InviteFragment"

class InviteFragment : Fragment(),InviteContract.View, OnCardClickListener {

    @Inject
    lateinit var presenter: InvitePresenter
    //View object
    private lateinit var fragment_view: View

    // Declare Context variable at class level in Fragment
    private lateinit var mContext: Context

    // recycler object and its adapter object declared
    private lateinit var inviteAdapter: UserInviteAdapter
    override lateinit var recyclerView: RecyclerView
    private lateinit var viewManager: RecyclerView.LayoutManager

    //cards to be shown in recyclerview
    private val inviteCardList=ArrayList<InviteCard>()
    private val invitedCardList = setOf<Int>()
    override var projectId : Int = -1;

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

    override fun onDestroy() {
        super.onDestroy()

        resetUserCardlist() // resets cardlist to be updated on the next call
        this.presenter.unbind()
    }

    override fun getLayout(): View {
        return this.fragment_view
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,savedInstanceState: Bundle?): View? {
        // Inflate the layout for this fragment
        projectId = arguments?.getInt("projectID")!! //receives the projectID from the previous fragment
        val view = inflater.inflate(R.layout.fragment_invite, container, false) //
        this.fragment_view=view


        view.findViewById<Button>(R.id.buttonOK).setOnClickListener {
            Navigation.findNavController(view).navigateUp() // to go back to the previous fragment
        }
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initRecyclerView()
        resetUserCardlist()
        this.presenter.bind(this)
    }

    override fun resetUserCardlist() {
        inviteCardList.clear() //clears the list of the cards
        inviteAdapter.submitList(this.inviteCardList) //update the data
        inviteAdapter.notifyDataSetChanged() //notify to update recyclerview
    }
    override fun submitUserCardList() {
        var message : String =""
        for (invite in inviteCardList){
            message += invite.username + ", "
        }

        inviteAdapter.submitList(this.inviteCardList)
        inviteAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun cardInviteCheck(id: Int,position : Int) {
    /*
        Changes the data on the hand without having another get call. So that unnecessary get calls
        to backend isn't made.
    */
        inviteCardList[position].called = true
        submitUserCardList()
        inviteAdapter.notifyDataSetChanged()
    }

    override fun cardUnInviteCheck(id: Int ,position : Int) {
        /*
            Changes the data on the hand without having another get call. So that unnecessary get calls
            to backend isn't made.
        */
        inviteCardList[position].called = false
        submitUserCardList()
        inviteAdapter.notifyDataSetChanged()
    }

    private fun initRecyclerView(){
        /*
            Initializes the already declared Recycler view.
        */
        viewManager = LinearLayoutManager(this.context)
        inviteAdapter= UserInviteAdapter(this)
        recyclerView = fragment_view.findViewById<RecyclerView>(R.id.recyclerViewInvites).apply{
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = inviteAdapter
        }


    }


    override fun onInviteButtonClick(item: InviteCard, position: Int) {
        this.presenter.OnInviteButtonClicked(item,position)
    }

    override fun onCardClick(userId: Int) {
        /*
            Navigates to the profile of the card clicked
        */
        val bundle = bundleOf("userID" to userId )
        Navigation.findNavController(requireView()).navigate(R.id.navigateToUserFromInvite, bundle)
    }


    override fun addUserCard(userId: Int, username: String, name : String, expertise: String?, photoURL : String?, id : Int, invited : Boolean) {
        /*
            Adds a usercard to the list to be shown in recyclerview
        */
        inviteCardList.add(
                InviteCard(
                        userId,
                        username,
                        name,
                        expertise,
                        photoURL,
                        id,
                        invited)
        )
    }

}