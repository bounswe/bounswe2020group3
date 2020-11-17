package com.bounswe2020group3.paperlayer.register

import android.view.View
import android.widget.EditText
import android.widget.TextView
import com.bounswe2020group3.paperlayer.R

class CreateUserService {
    companion object {
        public fun checkRegistration(view: View): Boolean {
            nameCheck(view)
            var p = passwordCheck(view) != null
            var e = emailCheck(view) != null
            var u = usernameCheck(view) != null
            return p && e && u

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
                view.findViewById<TextView>(R.id.errorPassword).visibility = View.INVISIBLE
                return password
            } else {
                view.findViewById<EditText>(R.id.editTextPasswordConfirm).setText("")
                view.findViewById<EditText>(R.id.editTextPassword).setText("")
                view.findViewById<TextView>(R.id.errorPassword).visibility = View.VISIBLE
                view.findViewById<TextView>(R.id.errorPassword).setText("The passwords entered does not match")
                return null
            }

        }
        fun nameCheck(view: View) : String?{
            var firstName = view.findViewById<EditText>(R.id.editTextFirstName).text.toString()
            var middleName: String = view.findViewById<EditText>(R.id.editTextMiddleName).text.toString()
            var lastName: String = view.findViewById<EditText>(R.id.editTextLastName).text.toString()
            if(firstName.length<1 || lastName.length <1){
                view.findViewById<TextView>(R.id.errorName).setText(R.string.err_invalid_name)
                view.findViewById<TextView>(R.id.errorName).visibility = View.VISIBLE

                return null
            }
            view.findViewById<TextView>(R.id.errorName).visibility = View.INVISIBLE

            return null
        }

        fun usernameCheck(view: View): String? {
            // TODO: add a system to check if the username has been taken
            var username = view.findViewById<EditText>(R.id.editTextUsername).text.toString()
            if (username.length < 6) {
                view.findViewById<TextView>(R.id.errorUsername).setText("You must enter a username at " +
                        "least length of 6 characters,which should not contain '*,-,/,(,{")
                view.findViewById<TextView>(R.id.errorUsername).visibility = View.VISIBLE
                return null
            }
            view.findViewById<TextView>(R.id.errorUsername).visibility = View.INVISIBLE

            return username

        }

        fun emailCheck(view: View): String? {
            // TODO: add a system to check if the email has been taken
            // TODO: add a system to check if the email exists
            var email = view.findViewById<EditText>(R.id.editTextEmail).text.toString()
            if (email == "") {
                view.findViewById<TextView>(R.id.errorEmail).setText("You must enter a valid email.")
                view.findViewById<TextView>(R.id.errorEmail).visibility = View.VISIBLE
                return null
            }
            view.findViewById<TextView>(R.id.errorEmail).visibility = View.INVISIBLE

            return email
        }
    }
}