package com.bounswe2020group3.paperlayer.profile.follow

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.data.follow.ListableFollow
import com.bounswe2020group3.paperlayer.data.user.User
import kotlinx.android.synthetic.main.fragment_user.*
import javax.inject.Inject

private const val ARG_FOLLOW_TYPE = "followType"
private const val ARG_USER_ID = "userID"

/**
 * A fragment representing a list of [User].
 */
class FollowListFragment : Fragment(), FollowContract.View, OnUserClickListener, OnFollowButtonClickListener {

    @Inject
    lateinit var presenter: FollowContract.Presenter

    private var followList: ArrayList<ListableFollow> = ArrayList()
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
        val view = inflater.inflate(R.layout.fragment_follow_list, container, false)

        this.presenter.bind(this)

        followListAdapter = FollowListAdapter(followList, this, this, followType)

        // Set the adapter
        if (view is RecyclerView) {
            view.layoutManager = LinearLayoutManager(this.context)
            view.adapter = followListAdapter
        }

        return view
    }

    override fun onResume() {
        super.onResume()
        loadList()
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

    override fun updateFollowListUI(followList: List<ListableFollow>) {
        this.followList.clear()
        this.followList.addAll(followList)
        followListAdapter.notifyDataSetChanged()
    }

    override fun loadList() {
        this.presenter.loadFollowList(userID, followType)
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }

    override fun onUserClick(user: User) {
        if (presenter.isUserAuthenticatedUser(user.id)) {
            Navigation.findNavController(requireView())
                    .navigate(R.id.navigateToProfileFromFollowList)
        } else {
            val bundle = bundleOf("userID" to user.id)
            Navigation.findNavController(requireView())
                    .navigate(R.id.navigateToUserFromFollowList, bundle)
        }
    }

    override fun onFollowButtonClick(user: User) {
        if(user.profile[0].is_public) {
            presenter.sendFollow(user.id)
        } else {
            presenter.sendFollowRequest(user.id)
        }
    }

    override fun onUnfollowButtonClick(user: User) {
        showInfoToast("Not implemented yet.")
    }

    override fun onAcceptRequestClick(followRequestId: Int, fromUser: User) {
        presenter.acceptRequest(followRequestId, fromUser.id)
    }

    override fun onRejectRequestClick(followRequestId: Int, fromUser: User) {
        presenter.rejectRequest(followRequestId, fromUser.id)
    }
}