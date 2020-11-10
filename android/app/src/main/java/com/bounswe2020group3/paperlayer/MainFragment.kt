package com.bounswe2020group3.paperlayer

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast

class MainFragment : Fragment(), MainContract.View {

    private lateinit var presenter: MainContract.Presenter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_main, container, false)
        setPresenter(MainPresenter(this, DependencyInjectorImpl()))
        presenter.onViewCreated()
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