package com.bounswe2020group3.paperlayer.profile.user

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.data.user.User
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.fragment_user.*
import javax.inject.Inject

private const val ARG_USER_ID = "userID"

class UserFragment : Fragment(), UserContract.View {

    @Inject lateinit var presenter: UserContract.Presenter

    private var userID: Int? = null

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            userID = it.getInt(ARG_USER_ID)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_user, container, false)
        presenter.bind(this)
        return view
    }

    override fun onResume() {
        super.onResume()
        if(userID != null) {
            presenter.loadUser(userID!!.toInt())
        } else {
            showErrorToast("User id is invalid. Please try again.")
            navigateBack()
        }
    }

    companion object {

        @JvmStatic
        fun newInstance(userId: Int) =
            UserFragment().apply {
                arguments = Bundle().apply {
                    putInt(ARG_USER_ID, userId)
                }
            }
    }

    override fun navigateBack() {
        Navigation.findNavController(requireView()).navigateUp()
    }

    override fun showLoading() {
        progressBarUser.visibility = View.VISIBLE
        layoutUserDetail.visibility = View.GONE
    }

    override fun hideLoading() {
        progressBarUser.visibility = View.GONE
        layoutUserDetail.visibility = View.VISIBLE
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }

    override fun updateProfileUI(user: User) {
        val profile = user.profile[0]
        val fullName = "${profile.name} ${profile.lastName}"

        textViewEmail.text = user.email
        textViewFullName.text = fullName
        textViewBio.text = profile.bio
        textViewBirthday.text = profile.birthday.toString()
        textViewGender.text = profile.gender
        textViewInterests.text = profile.interests
        textViewExpertise.text = profile.expertise

        val imageUrl = profile.profile_picture
        if(imageUrl != null && imageUrl.contains("http")) {
            Picasso.get().load(imageUrl).into(imageViewProfileAvatar)
        }
    }

}