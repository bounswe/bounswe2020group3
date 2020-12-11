package com.bounswe2020group3.paperlayer.register


import android.content.Context
import android.os.Bundle

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.fragment.app.Fragment
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.main.MainContract
import com.bounswe2020group3.paperlayer.main.MainPresenter
import kotlinx.android.synthetic.main.fragment_profile.*
import kotlinx.android.synthetic.main.fragment_register.*
import kotlinx.coroutines.awaitAll
import javax.inject.Inject

class RegisterFragment : Fragment(), RegisterContract.View {

    @Inject lateinit var presenter: RegisterContract.Presenter
    lateinit var lateview : View
    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?): View? {

        presenter.bind(this)
        return inflater.inflate(R.layout.fragment_register, container, false)
        }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        view.findViewById<Button>(R.id.buttonRegister).setOnClickListener {
            var register = CreateUserService.checkRegistration(view)
            if(register != null){
                showLoading()
                presenter.register(register)

                //showToast("Thank you for registering.\n An Email will be sent for you to activate your account")
                hideLoading()
            }
        }
        lateview = view
        hideLoading()
    }
    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }
    override fun navigatetologin(){
        Navigation.findNavController(lateview).navigate(R.id.navigateToLoginFromRegister)
    }

    override fun showLoading() {
        view?.findViewById<ProgressBar>(R.id.progressBarRegister)?.visibility = View.VISIBLE
        view?.findViewById<LinearLayout>(R.id.layoutRegister)?.visibility = View.GONE

    }

    override fun hideLoading() {
        view?.findViewById<ProgressBar>(R.id.progressBarRegister)?.visibility = View.GONE
        view?.findViewById<LinearLayout>(R.id.layoutRegister)?.visibility = View.VISIBLE
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }


    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()

    }


    override fun onDestroy() {
        super.onDestroy()
    }



}