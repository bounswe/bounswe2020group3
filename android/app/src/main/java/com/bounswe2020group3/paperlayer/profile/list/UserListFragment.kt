package com.bounswe2020group3.paperlayer.profile.list

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
import com.bounswe2020group3.paperlayer.data.user.User
import javax.inject.Inject

private const val ARG_PEOPLE_LIST = "people-list"

/**
 * A fragment representing a list of [User].
 */
class UserListFragment : Fragment(), UserListContract.View, OnUserClickListener {

    @Inject
    lateinit var presenter: UserListContract.Presenter

    private var userList: ArrayList<User> = ArrayList()
    private lateinit var userListAdapter: UserListAdapter

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.unbind()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_user_list, container, false)

        this.presenter.bind(this)

        userListAdapter = UserListAdapter(userList, this)

        // Set the adapter
        if (view is RecyclerView) {
            view.layoutManager = LinearLayoutManager(this.context)
            view.adapter = userListAdapter
        }

        return view
    }

    override fun onResume() {
        super.onResume()
        this.presenter.loadUserList()
    }

    companion object {

        @JvmStatic
        fun newInstance(peopleList: ArrayList<User>) =
            UserListFragment().apply {
                arguments = Bundle().apply {
                    putSerializable(ARG_PEOPLE_LIST, peopleList)
                }
            }
    }

    override fun updateUserListUI(userList: List<User>) {
        this.userList.addAll(userList)
        userListAdapter.notifyDataSetChanged()
    }

    override fun navigateToUser() {

    }

    override fun onUserClick(user: User) {
        val bundle = bundleOf("userID" to user.id )
        Navigation.findNavController(requireView()).navigate(R.id.navigateToUserFromUserList, bundle)
    }

}