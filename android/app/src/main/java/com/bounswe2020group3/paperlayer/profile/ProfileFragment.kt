package com.bounswe2020group3.paperlayer.profile

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
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

    override fun onStart() {
        super.onStart()
        buttonProfileFetch.setOnClickListener { _ ->
            presenter.fetchProfile(1)
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
        textViewProfileName.text = profile?.name
        textViewProfileMiddleName.text = profile?.middleName
        textViewProfileLastName.text = profile?.lastName
    }

    override fun showLoading() {
        progressBarProfile.visibility = View.VISIBLE
    }

    override fun hideLoading() {
        progressBarProfile.visibility = View.INVISIBLE
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }
}