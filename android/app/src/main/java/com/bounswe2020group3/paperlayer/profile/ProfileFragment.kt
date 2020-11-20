package com.bounswe2020group3.paperlayer.profile

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.profile.data.Profile
import kotlinx.android.synthetic.main.fragment_profile.*


class ProfileFragment : Fragment(), ProfileContract.View {

    private lateinit var presenter: ProfileContract.Presenter

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        setPresenter(ProfilePresenter(this))
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_profile, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        presenter.fetchProfile(1)

        imageButtonSettings.setOnClickListener{
            Navigation.findNavController(view).navigate(R.id.navigateToProfileEditFromProfile)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.onDestroy()
    }

    override fun setPresenter(presenter: ProfileContract.Presenter) {
        this.presenter = presenter
    }

    override fun updateProfileUI(profile: Profile?) {
        val fullName = "${profile?.name} ${profile?.lastName}"
        textViewFullName.text = fullName
        textViewBio.text = profile?.bio
        textViewAge.text = profile?.age.toString()
        textViewGender.text = profile?.gender
        textViewInterests.text = profile?.interests
        textViewExpertise.text = profile?.expertise
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