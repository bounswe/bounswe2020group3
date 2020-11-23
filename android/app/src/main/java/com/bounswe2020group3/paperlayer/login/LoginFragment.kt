package com.bounswe2020group3.paperlayer.login

import android.content.Context
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import kotlinx.android.synthetic.main.fragment_login.view.*
import javax.inject.Inject

private const val TAG = "LoginFragment"

class LoginFragment : Fragment(),LoginContract.View {

    //Presenter object
    @Inject
    lateinit var presenter: LoginPresenter

    //View object
    private lateinit var fragmentView: View

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        this.presenter.unbind()
        writeLogMessage("i", TAG,"LoginFragment destroyed.")
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_login, container, false)
        this.fragmentView=view
        this.presenter.bind(this)
        writeLogMessage("i", TAG,"LoginFragment view created")
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
    }

    override fun initOnClicks() {
        fragmentView.buttonLogin.setOnClickListener {
            this.presenter.onLoginButtonClicked(fragmentView.editTextUsername.editText?.text.toString(),fragmentView.editTextLoginPassword.editText?.text.toString())
        }
        fragmentView.buttonRegister.setOnClickListener {
            this.presenter.onRegisterButtonClicked(fragmentView.editTextUsername.editText?.text.toString(),fragmentView.editTextLoginPassword.editText?.text.toString())
        }
        fragmentView.buttonGuest.setOnClickListener {
            this.presenter.onGuestButtonClicked(fragmentView.editTextUsername.editText?.text.toString(),fragmentView.editTextLoginPassword.editText?.text.toString())
        }
    }

    override fun getLayout(): View {
        return this.fragmentView
    }

    override fun resetEditText() {
        fragmentView.editTextUsername.editText?.text?.clear()
        fragmentView.editTextLoginPassword.editText?.text?.clear()
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun writeLogMessage(type:String ,tag: String,message: String) {
        when(type){
            "e"-> Log.e(tag,message) //error
            "w"-> Log.w(tag,message) //warning
            "i"-> Log.i(tag,message) //information
            "d"-> Log.d(tag,message) //debug
            "v"-> Log.v(tag,message) //verbose
            else-> Log.e(tag,"Type is not defined")
        }
    }

}