package com.bounswe2020group3.paperlayer

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.AttributeSet
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.Toast
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.fragment_login.*
import timber.log.Timber

class MainActivity : AppCompatActivity(), MainContract.View {

    private lateinit var presenter: MainContract.Presenter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setPresenter(MainPresenter(this, DependencyInjectorImpl()))
        presenter.onViewCreated()
        buttonDemo.setOnClickListener {
            onDemoTap()
        }
    }

    override fun onDestroy() {
        presenter.onDestroy()
        super.onDestroy()
    }

    override fun onDemoTap() {
        presenter.demo()
    }

    override fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }


    override fun setPresenter(presenter: MainContract.Presenter) {
        this.presenter = presenter
    }
}