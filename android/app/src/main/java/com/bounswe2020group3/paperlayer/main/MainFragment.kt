package com.bounswe2020group3.paperlayer.main

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.Toast
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.fragment_main.*

class MainFragment : Fragment(), MainContract.View {

    private lateinit var presenter: MainContract.Presenter

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).hideBottomNav()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_main, container, false)
        setPresenter(MainPresenter(this))
        presenter.onViewCreated()
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        loginButton.setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.navigateToLogin)
        }
        registerButton.setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.navigateToRegisterFromMain)
        }
    }

    override fun onDestroy() {
        presenter.onDestroy()
        super.onDestroy()
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun setPresenter(presenter: MainContract.Presenter) {
        this.presenter = presenter
    }
}