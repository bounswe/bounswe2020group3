package com.bounswe2020group3.paperlayer.profile.follow

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.os.bundleOf
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.data.follow.Follow
import com.bounswe2020group3.paperlayer.data.follow.FollowType
import com.bounswe2020group3.paperlayer.data.user.User
import javax.inject.Inject

private const val ARG_FOLLOW_TYPE = "followType"
private const val ARG_USER_ID = "userID"

/**
 * A fragment representing a list of [User].
 */
class FollowListFragment : Fragment(), FollowContract.View, OnUserClickListener {

    @Inject
    lateinit var presenter: FollowContract.Presenter

    private var followList: ArrayList<Follow> = ArrayList()
    private lateinit var followListAdapter: FollowListAdapter

    private var userID: Int? = null
    private var followType: FollowType? = null

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.unbind()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            userID = it.getInt(ARG_USER_ID)
            followType = it.getParcelable(ARG_FOLLOW_TYPE)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_user_list, container, false)

        this.presenter.bind(this)

        followListAdapter = FollowListAdapter(followList, this, followType)

        // Set the adapter
        if (view is RecyclerView) {
            view.layoutManager = LinearLayoutManager(this.context)
            view.adapter = followListAdapter
        }

        return view
    }

    override fun onResume() {
        super.onResume()
        this.presenter.loadFollowList(userID, followType)
    }

    companion object {

        @JvmStatic
        fun newInstance(userID: Int, followType: FollowType) =
            FollowListFragment().apply {
                arguments = Bundle().apply {
                    putSerializable(ARG_FOLLOW_TYPE, followType)
                    putInt(ARG_USER_ID, userID)
                }
            }
    }

    override fun updateFollowListUI(followList: List<Follow>) {
        this.followList.clear()
        this.followList.addAll(followList)
        followListAdapter.notifyDataSetChanged()
    }

    override fun navigateToUser() {

    }

    override fun onUserClick(user: User) {
        val bundle = bundleOf("userID" to user.id)
        Navigation.findNavController(requireView())
            .navigate(R.id.navigateToUserFromFollowList, bundle)
    }

}