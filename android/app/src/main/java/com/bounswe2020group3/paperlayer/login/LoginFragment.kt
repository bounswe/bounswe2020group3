package com.bounswe2020group3.paperlayer.login

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import com.bounswe2020group3.paperlayer.R

class LoginFragment : Fragment(),LoginContract.View {

    //My presenter object
    private lateinit var mPresenter: LoginPresenter
    //My view
    private lateinit var mView: View

    //My UI elements
    private lateinit var loginButton: Button
    private lateinit var registerButton: Button
    private lateinit var guestButton: Button
    private lateinit var mailEditText: EditText
    private lateinit var passwordEditText: EditText


    /*
    * Creates LoginPresenter Object and setView
    * */
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        this.mPresenter=LoginPresenter()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_login, container, false)
        this.mView=view
        this.mPresenter.setView(this)
        this.mPresenter.created()
        return view
    }

    override fun bindViews() {
        this.loginButton=mView.findViewById(R.id.fr_login_loginButton)
        this.registerButton=mView.findViewById(R.id.fr_login_registerButton)
        this.guestButton=mView.findViewById(R.id.fr_login_loginGuestButton)
        this.mailEditText=mView.findViewById(R.id.fr_login_usernameEditText)
        this.passwordEditText=mView.findViewById(R.id.fr_login_passwordEditText)
    }

    override fun initOnClicks() {
        this.loginButton.setOnClickListener {
            this.mPresenter.onLoginButtonClicked(mailEditText,passwordEditText)
        }
        this.registerButton.setOnClickListener {
            this.mPresenter.onRegisterButtonClicked(mailEditText,passwordEditText)
        }
        this.guestButton.setOnClickListener {
            this.mPresenter.onGuestButtonClicked(mailEditText,passwordEditText)
        }
    }

    override fun getLayout(): View {
        return this.mView
    }
}