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
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.main.MainContract
import com.bounswe2020group3.paperlayer.main.MainPresenter
import kotlinx.android.synthetic.main.fragment_profile.*

class RegisterFragment : Fragment(), RegisterContract.View {

    private lateinit var presenter: RegisterContract.Presenter
    private lateinit var navigator : NavController
    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_register, container, false)
        setPresenter(RegisterPresenter(this))
        presenter.onViewCreated()
        navigator = Navigation.findNavController(view)
        view.findViewById<Button>(R.id.buttonRegister).setOnClickListener {
            var register = CreateUserService.checkRegistration(view)
            if(register != null){
                presenter.register(register)
                showToast("Thank you for registering.\n An Email will be sent for you to activate your account")

            }
        }

        return view
    }
    override fun navigateToLogin(){
        navigator.navigate(R.id.navigateToLoginFromRegister)

    }
    override fun showLoading() {
        progressBarProfile.visibility = View.VISIBLE
        layoutProfileDetail.visibility = View.GONE
    }

    override fun hideLoading() {
        progressBarProfile.visibility = View.GONE
        layoutProfileDetail.visibility = View.VISIBLE
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
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



}