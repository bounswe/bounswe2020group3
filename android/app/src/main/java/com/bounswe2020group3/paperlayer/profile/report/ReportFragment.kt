package com.bounswe2020group3.paperlayer.profile.report

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.RadioButton
import android.widget.Toast
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.profile.user.UserContract
import kotlinx.android.synthetic.main.fragment_project_create.*
import kotlinx.android.synthetic.main.fragment_report.*
import javax.inject.Inject

private const val USER_ID = "userID"

class ReportFragment : Fragment(), ReportContract.View {
    private var userID: Int = -1

    @Inject
    lateinit var presenter: ReportContract.Presenter

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            userID = it.getInt(USER_ID)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        presenter.bind(this)
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_report, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        if (userID < -1) {
            showErrorToast("A user must be provided to report")
            navigateBack()
        }

        buttonSendReport.setOnClickListener {
            val selectedRadioButtonId = radioGroupReportType.checkedRadioButtonId
            if (selectedRadioButtonId < 0) {
                showErrorToast("Please select a type")
            } else {
                val selectedRadioButton = view.findViewById<RadioButton>(selectedRadioButtonId)
                val type: String = selectedRadioButton.text.toString()
                val description: String = editTextReportDescription.text.toString()
                if (userID > -1) {
                    presenter.sendReport(type, userID!!, description)
                } else {
                    showErrorToast("User id not found. Please try again")
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.unbind()
    }

    companion object {

        @JvmStatic
        fun newInstance(userId: Int) =
            ReportFragment().apply {
                arguments = Bundle().apply {
                    putInt(USER_ID, userId)
                }
            }
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }


    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }

    override fun navigateBack() {
        Navigation.findNavController(requireView()).navigateUp()
    }
}