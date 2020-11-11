package com.bounswe2020group3.paperlayer.register


import android.os.Bundle

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.main.MainContract
import com.bounswe2020group3.paperlayer.main.MainPresenter

class RegisterFragment : Fragment(), RegisterContract.View {

    private lateinit var presenter: RegisterContract.Presenter
    //private lateinit var name : String
    //private lateinit var password : String
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_register, container, false)
        setPresenter(RegisterPresenter(this))
        presenter.onViewCreated()
       view.findViewById<Button>(R.id.buttonRegister).setOnClickListener {
           if(checkRegistration(view)){
               Navigation.findNavController(view).navigate(R.id.navigateToLoginFromRegister)
               showToast("Thank you for registering.\n An Email will be sent for you to activate your account")

           }


       }

        return view
    }
    fun checkRegistration(view : View): Boolean {
        var p = passwordCheck(view) != null
        var e = emailCheck(view) != null
        var u = usernameCheck(view) != null
        return p && e && u

    }
    fun passwordCheck(view : View) : String? {
        var password = view.findViewById<EditText>(R.id.editTextPassword).text.toString()
        var confirmPassword : String = view.findViewById<EditText>(R.id.editTextPasswordConfirm).text.toString()
        if ( password.length < 6){
            view.findViewById<EditText>(R.id.editTextPasswordConfirm).setText("")
            view.findViewById<EditText>(R.id.editTextPassword).setText("")
            view.findViewById<TextView>(R.id.errorPassword).visibility = View.VISIBLE
            view.findViewById<TextView>(R.id.errorPassword).setText("You must enter a password at " +
                    "least length of 6 characters,which should not contain '*,-,/,(,{")
            return null
        }
        else if(password == confirmPassword) {
            return password
        }
        else{
            view.findViewById<EditText>(R.id.editTextPasswordConfirm).setText("")
            view.findViewById<EditText>(R.id.editTextPassword).setText("")
            view.findViewById<TextView>(R.id.errorPassword).visibility = View.VISIBLE
            view.findViewById<TextView>(R.id.errorPassword).setText("The passwords entered does not match")
            return null
        }

    }
    fun usernameCheck(view : View) : String ?{
        // TODO: add a system to check if the username has been taken
        var username = view.findViewById<EditText>(R.id.editTextUsername).text.toString()
        if (username.length < 6){
            view.findViewById<TextView>(R.id.errorUsername).setText("You must enter a username at " +
                    "least length of 6 characters,which should not contain '*,-,/,(,{")
            view.findViewById<TextView>(R.id.errorUsername).visibility = View.VISIBLE
            return null
        }
        return  username

    }
    fun emailCheck(view : View) : String?{
        // TODO: add a system to check if the email has been taken
        // TODO: add a system to check if the email exists
        var email = view.findViewById<EditText>(R.id.editTextEmail).text.toString()
        if(email == "") {
            view.findViewById<TextView>(R.id.errorEmail).setText("You must enter a valid email.")
            view.findViewById<TextView>(R.id.errorEmail).visibility = View.VISIBLE
            return null
        }
        return email
    }
    override fun setPresenter(presenter: RegisterContract.Presenter) {
        this.presenter = presenter
    }
    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()

    }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        showToast("hello")
    }

    override fun onDestroy() {
        presenter.onDestroy()
        super.onDestroy()
    }

    override fun onDemoTap() {
        presenter.demo()
    }



}