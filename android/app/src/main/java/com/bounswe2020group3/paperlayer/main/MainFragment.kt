package com.bounswe2020group3.paperlayer.main

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.Toast
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R

class MainFragment : Fragment(), MainContract.View {

    private lateinit var presenter: MainContract.Presenter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_main, container, false)
        setPresenter(MainPresenter(this))
        presenter.onViewCreated()
        view.findViewById<Button>(R.id.loginButton).setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.navigateToLogin)
        }
        view.findViewById<Button>(R.id.registerButton).setOnClickListener {
            Navigation.findNavController(view).navigate(R.id.navigateToRegisterFromMain)
        }
        return view
    }

    override fun onDestroy() {
        presenter.onDestroy()
        super.onDestroy()
    }

    override fun onDemoTap() {
        presenter.demo()
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun setPresenter(presenter: MainContract.Presenter) {
        this.presenter = presenter
    }
}