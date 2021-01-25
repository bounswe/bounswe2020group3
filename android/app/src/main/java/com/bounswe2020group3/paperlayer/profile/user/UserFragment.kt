package com.bounswe2020group3.paperlayer.profile.user

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.data.user.User
import com.bounswe2020group3.paperlayer.profile.follow.FollowType
import com.bounswe2020group3.paperlayer.util.Session
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.fragment_user.*
import javax.inject.Inject

private const val ARG_USER_ID = "userID"

class UserFragment : Fragment(), UserContract.View {

    @Inject
    lateinit var sessionManager: Session
    @Inject
    lateinit var presenter: UserContract.Presenter

    private var userID: Int? = -1
    private var isFollowRequest = true

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

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        buttonUserFollow.setOnClickListener {
            if (this.userID != null && this.userID!! > 0) {
                if (this.isFollowRequest) {
                    presenter.sendFollowRequest(userID!!)
                } else {
                    presenter.sendFollow(userID!!)
                }
            }
        }

        buttonUserUnfollow.setOnClickListener {
            showInfoToast("Not implemented. You can perform unfollow operation in followings page.")
        }

        val followerBundle = bundleOf("followType" to FollowType.FOLLOWER, "userID" to userID)

        val followingBundle = bundleOf("followType" to FollowType.FOLLOWING, "userID" to userID)

        val publicationBundle = bundleOf("authorID" to userID)

        linearLayoutPublications.setOnClickListener {
            Navigation.findNavController(view)
                .navigate(R.id.navigateToPublicationFromUser, publicationBundle)
        }

        layoutUserFollowers.setOnClickListener {
            Navigation.findNavController(view)
                .navigate(R.id.navigateToFollowListFromUser, followerBundle)
        }

        layoutUserFollowings.setOnClickListener {
            Navigation.findNavController(view)
                .navigate(R.id.navigateToFollowListFromUser, followingBundle)
        }

        imageViewReportUser.setOnClickListener {
            val reportBundle = bundleOf("userID" to userID)
            Navigation.findNavController(view).navigate(R.id.navigateToReportFromUser, reportBundle)
        }
    }

    override fun onResume() {
        super.onResume()
        this.loadUser()
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
        try {
            val profile = user.profile.first()
            val fullName = "${profile.name} ${profile.lastName}"
            textViewFullName.text = fullName

            val imageUrl = profile.profile_picture
            if (imageUrl != null && imageUrl != "") {
                Picasso.get().load(imageUrl).into(imageViewProfileAvatar)
            }

            if (profile.is_public || user.isFollowing) {
                // Public or following profile
                // Private Profile
                this.isFollowRequest = false

                // Layouts
                layoutUserStatsWrapper.visibility = View.VISIBLE
                layoutUserInformationWrapper.visibility = View.VISIBLE
                layoutUserPrivateWrapper.visibility = View.GONE

                // Bio
                if (profile.bio == null || profile.bio == "") {
                    layoutUserBioWrapper.visibility = View.GONE
                } else {
                    layoutUserBioWrapper.visibility = View.VISIBLE
                    textViewBio.text = profile.bio
                }

                // Text Views
                textViewEmail.text = user.email
                textViewBirthday.text = profile.birthday.toString()
                textViewGender.text = profile.gender
                textViewInterests.text = profile.interests
                textViewExpertise.text = profile.expertise

                // Stats
                textViewProfileFollowers.text = user.countOfFollowers.toString()
                textViewProfileFollowings.text = user.countOfFollowings.toString()
                textViewProfileRating.text = if (profile.rating == null) {
                    "N/A"
                } else {
                    String.format("%.2f", profile.rating)
                }

                // Buttons
                buttonUserRequestSent.visibility = View.GONE
                if (user.isFollowing) {
                    buttonUserFollow.visibility = View.GONE
                    buttonUserUnfollow.visibility = View.VISIBLE
                } else {
                    buttonUserFollow.visibility = View.VISIBLE
                    buttonUserUnfollow.visibility = View.GONE
                }
            } else {
                // Private Profile
                this.isFollowRequest = true

                layoutUserStatsWrapper.visibility = View.GONE
                layoutUserBioWrapper.visibility = View.GONE
                layoutUserInformationWrapper.visibility = View.GONE
                layoutUserPrivateWrapper.visibility = View.VISIBLE

                // Buttons
                buttonUserUnfollow.visibility = View.GONE
                if (user.isFollowRequestSent) {
                    buttonUserRequestSent.visibility = View.VISIBLE
                    buttonUserFollow.visibility = View.GONE
                } else {
                    buttonUserRequestSent.visibility = View.GONE
                    buttonUserFollow.visibility = View.VISIBLE
                }
            }
        } catch (e: NoSuchElementException) {
            e.printStackTrace()
            showErrorToast("An error occurred, please try again.")
        }
    }

    override fun loadUser() {
        if (userID != null && userID!! > 0) {
            presenter.loadUser(userID!!)
        } else {
            showErrorToast("User id is invalid. Please try again.")
            navigateBack()
        }
    }

    override fun navigateToProfile() {
        Navigation.findNavController(requireView()).navigate(R.id.navigateToProfileFromUser)
    }

}