package com.bounswe2020group3.paperlayer.login

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.fragment_login.view.*

class LoginFragment : Fragment(),LoginContract.View {

    //Presenter object
    private lateinit var presenter: LoginPresenter
    //View object
    private lateinit var fragment_view: View

    /*
    * Creates LoginPresenter Object and setView
    * */
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        this.presenter=LoginPresenter()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_login, container, false)
        this.fragment_view=view
        this.presenter.setView(this)
        this.presenter.created()
        return view
    }

    override fun initOnClicks() {
        fragment_view.buttonLogin.setOnClickListener {
            this.presenter.onLoginButtonClicked(fragment_view.editTextUsername,fragment_view.editTextLoginPassword)
        }
        fragment_view.buttonRegister.setOnClickListener {
            this.presenter.onRegisterButtonClicked(fragment_view.editTextUsername,fragment_view.editTextLoginPassword)
        }
        fragment_view.buttonGuest.setOnClickListener {
            this.presenter.onGuestButtonClicked(fragment_view.editTextUsername,fragment_view.editTextLoginPassword)
        }
    }

    override fun getLayout(): View {
        return this.fragment_view
    }

    override fun resetEditText() {
        fragment_view.editTextUsername.text.clear()
        fragment_view.editTextLoginPassword.text.clear()
    }
}