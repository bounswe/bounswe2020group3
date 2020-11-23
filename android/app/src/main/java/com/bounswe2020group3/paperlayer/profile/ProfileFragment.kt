package com.bounswe2020group3.paperlayer.profile

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.profile.data.User
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.fragment_profile.*
import javax.inject.Inject


class ProfileFragment : Fragment(), ProfileContract.View {

    @Inject
    lateinit var presenter: ProfileContract.Presenter

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        presenter.bind(this)
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_profile, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        presenter.subscribeUser()

        imageButtonSettings.setOnClickListener{
            Navigation.findNavController(view).navigate(R.id.navigateToProfileEditFromProfile)
        }
    }

    override fun onResume() {
        super.onResume()
        presenter.loadUser()
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.unbind()
    }

    override fun updateProfileUI(user: User) {
        val profile = user.profile[0]
        val fullName = "${profile.name} ${profile.lastName}"

        textViewEmail.text = user.email
        textViewFullName.text = fullName
        textViewBio.text = profile.bio
        textViewAge.text = profile.age.toString()
        textViewGender.text = profile.gender
        textViewInterests.text = profile.interests
        textViewExpertise.text = profile.expertise

        val imageUrl = profile.photoUrl
        if(imageUrl != null && imageUrl.contains("http")) {
            Picasso.get().load(imageUrl).into(imageViewProfileAvatar)
        }
    }

    override fun navigateToLogin() {
        Navigation.findNavController(requireView()).navigate(R.id.navigateToLoginFromProfile)
    }

    override fun showLoading() {
        progressBarProfile.visibility = View.VISIBLE
        layoutProfileDetail.visibility = View.GONE
    }

    override fun hideLoading() {
        progressBarProfile.visibility = View.GONE
        layoutProfileDetail.visibility = View.VISIBLE
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }
}