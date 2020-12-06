package com.bounswe2020group3.paperlayer.invite

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.MainActivity

import javax.inject.Inject

class InviteFragment : Fragment(),InviteContract.View {

    @Inject
    lateinit var presenter: InvitePresenter

    //View object
    private lateinit var fragmentView: View

    //Adapter Object
    private lateinit var projectAdapter: UserInviteAdapter

    // Declare Context variable at class level in Fragment
    private lateinit var mContext: Context
    private lateinit var recyclerView: RecyclerView

    //Project Card List
    private val projectCardList=ArrayList<InviteCard>()

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
        mContext=context
    }

    override fun onDestroy() {
        super.onDestroy()

        resetUserCardlist()
        this.presenter.unbind()
    }

    override fun getLayout(): View {
        return this.fragmentView
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return super.onCreateView(inflater, container, savedInstanceState)
    }

    override fun resetUserCardlist() {
        projectCardList.clear()
        projectAdapter.submitList(this.projectCardList)
        projectAdapter.notifyDataSetChanged() //notify to update recyclerview
         }
    override fun submitUserCardList() {
        projectAdapter.submitList(this.projectCardList)
        projectAdapter.notifyDataSetChanged() //notify to update recyclerview
    }


    override fun addUserCard(username: String,name : String, expertise: String, photoURL : String) {
        projectCardList.add(
            InviteCard(
                username,name,
                expertise,
                 photoURL)
        )
    }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
    }
}