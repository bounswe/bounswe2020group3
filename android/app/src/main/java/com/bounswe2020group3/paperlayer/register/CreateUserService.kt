package com.bounswe2020group3.paperlayer.register

import android.view.View
import android.widget.EditText
import android.widget.TextView
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.register.data.Register

class CreateUserService {
    companion object {
        public fun checkRegistration(view: View): Register? {
            var p = passwordCheck(view)
            var e = emailCheck(view)
            var u = usernameCheck(view)
            var fn = firstnameCheck(view)
            var ln = lastnameCheck(view)
            if (p != null &&
                e != null &&
                u != null &&
                fn != null &&
                ln != null
            )
                return Register(fn, "", ln, u, e, p)
                //return Register("mahir","efe","kaya","mahoe6996","mhrfky@gmail.com","mmm1996")
            return null
        }


        fun passwordCheck(view: View): String? {
            var password = view.findViewById<EditText>(R.id.editTextPassword).text.toString()
            var confirmPassword: String = view.findViewById<EditText>(R.id.editTextPasswordConfirm).text.toString()
            if (password.length < 6) {
                view.findViewById<EditText>(R.id.editTextPasswordConfirm).setText("")
                view.findViewById<EditText>(R.id.editTextPassword).setText("")
                view.findViewById<TextView>(R.id.errorPassword).visibility = View.VISIBLE
                view.findViewById<TextView>(R.id.errorPassword).setText("You must enter a password at " +
                        "least length of 6 characters,which should not contain '*,-,/,(,{")
                return null
            } else if (password == confirmPassword) {
                return password
            } else {
                view.findViewById<EditText>(R.id.editTextPasswordConfirm).setText("")
                view.findViewById<EditText>(R.id.editTextPassword).setText("")
                view.findViewById<TextView>(R.id.errorPassword).visibility = View.VISIBLE
                view.findViewById<TextView>(R.id.errorPassword).setText("The passwords entered does not match")
                return null
            }

        }

        fun usernameCheck(view: View): String? {
            var username = view.findViewById<EditText>(R.id.editTextUsername).text.toString()
            if (username.length < 6) {
                view.findViewById<TextView>(R.id.errorUsername).setText("You must enter a username at " +
                        "least length of 6 characters,which should not contain '*,-,/,(,{")
                view.findViewById<TextView>(R.id.errorUsername).visibility = View.VISIBLE
                return null
            }
            return username

        }

        fun emailCheck(view: View): String? {

            var email = view.findViewById<EditText>(R.id.editTextEmail).text.toString()
            if (email == "") {
                view.findViewById<TextView>(R.id.errorEmail).setText("You must enter a valid email.")
                view.findViewById<TextView>(R.id.errorEmail).visibility = View.VISIBLE
                return null
            }
            return email
        }
        fun firstnameCheck(view:View) : String? {

            var firstname = view.findViewById<EditText>(R.id.editTextFirstName).text.toString()
            if(firstname == ""){
                view.findViewById<TextView>(R.id.errorName).visibility = View.VISIBLE
                view.findViewById<TextView>(R.id.errorName).setText(R.string.err_invalid_name)

                return null
            }
            view.findViewById<TextView>(R.id.errorName).visibility = View.INVISIBLE

            return firstname
        }
        fun lastnameCheck(view:View) : String? {

            var lastname = view.findViewById<EditText>(R.id.editTextLastName).text.toString()
            if( lastname == ""){
                view.findViewById<TextView>(R.id.errorName).visibility = View.VISIBLE
                view.findViewById<TextView>(R.id.errorName).setText(R.string.err_invalid_name)

                return null
            }
            view.findViewById<TextView>(R.id.errorName).visibility = View.INVISIBLE

            return lastname
        }
    }
}