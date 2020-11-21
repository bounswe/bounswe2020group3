package com.bounswe2020group3.paperlayer.profile.edit

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.bounswe2020group3.paperlayer.R


class ProfileEditFragment : Fragment(), ProfileEditContract.View {

    private lateinit var presenter: ProfileEditContract.Presenter

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        setPresenter(ProfileEditPresenter(this))
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_profile_edit, container, false)
    }

    override fun setPresenter(presenter: ProfileEditContract.Presenter) {
        this.presenter = presenter
    }

}