package com.bounswe2020group3.paperlayer.projectCreate

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.*
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.google.android.material.datepicker.MaterialDatePicker
import kotlinx.android.synthetic.main.fragment_project_create.*
import timber.log.Timber
import java.util.*
import javax.inject.Inject

class ProjectCreateFragment : Fragment(), ProjectCreateContract.View {

    @Inject
    lateinit var presenter: ProjectCreateContract.Presenter

    private lateinit var projectType: String
    private lateinit var projectState: String


    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        presenter.bind(this)

        return inflater.inflate(R.layout.fragment_project_create, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        var isPublic = true

        radioGroupIsPublic.setOnClickListener {
            it.hideKeyboard()
        }
        radioGroupIsPublic.setOnCheckedChangeListener { radioGroup, _ ->
            view.hideKeyboard()
            isPublic = radioGroup.checkedRadioButtonId == R.id.radioButtonYes
        }


        val projectStates = ProjectState.toList()
        val projectStateAdapter =
                ArrayAdapter(requireContext(), R.layout.spinner_item, projectStates)
        projectStateAdapter.setDropDownViewResource(R.layout.spinner_item)
        spinnerProjectState.adapter = projectStateAdapter

        spinnerProjectState.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(
                    parent: AdapterView<*>?,
                    view: View?,
                    position: Int,
                    id: Long
            ) {
                projectState =
                        parent?.getItemAtPosition(position).toString().toLowerCase(Locale.ROOT)
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
                Timber.d("Nothing selected")
            }
        }

        val projectTypes = ProjectType.toList()

        val projectTypeAdapter = ArrayAdapter(requireContext(), R.layout.spinner_item, projectTypes)
        projectTypeAdapter.setDropDownViewResource(R.layout.spinner_item)
        spinnerProjectType.adapter = projectTypeAdapter

        spinnerProjectType.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(
                    parent: AdapterView<*>?,
                    view: View?,
                    position: Int,
                    id: Long
            ) {
                projectType =
                        parent?.getItemAtPosition(position).toString().toLowerCase(Locale.ROOT)
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
                Timber.d("Nothing selected")
            }
        }

        val builder = MaterialDatePicker.Builder.datePicker()
        builder.setTitleText("Select a date")
        val datePicker = builder.build()
        val calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"))

        datePicker.addOnPositiveButtonClickListener {
            textViewDate.text = displayTime(calendar, it)
            textViewDate.setTextColor(resources.getColor(R.color.colorBlack))
        }
        buttonDatePicker.setOnClickListener {
            datePicker.show(requireActivity().supportFragmentManager, "DATE_PICKER")
        }

        buttonCreateProject.setOnClickListener {
            presenter.createProject(
                    ProjectCreateRequest(
                            name = editTextProjectName.text.toString(),
                            description = editTextDescription.text.toString(),
                            requirements = editTextRequirements.text.toString(),
                            members = null,
                            is_public = isPublic,
                            state = projectState,
                            project_type = projectType,
                            due_date = textViewDate.text.toString(),
                            events = null,
                            tags = null,
                    )
            )
        }

        val onFocusChangeListener = View.OnFocusChangeListener { v, hasFocus ->
            if (!hasFocus) {
                v.hideKeyboard()
            }
        }
        editTextProjectName.onFocusChangeListener = onFocusChangeListener
        editTextDescription.onFocusChangeListener = onFocusChangeListener
        editTextRequirements.onFocusChangeListener = onFocusChangeListener
    }

    private fun View.hideKeyboard() {
        val imm = context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(windowToken, 0)
    }

    override fun showProgress(show: Boolean) {
        if (show) {
            progressBar.visibility = View.VISIBLE
            buttonCreateProject.isEnabled = false
        } else {
            progressBar.visibility = View.GONE
            buttonCreateProject.isEnabled = true
        }
    }

    override fun showSuccess() {
        progressBar.visibility = View.GONE
        buttonCreateProject.visibility = View.GONE
        layoutCreateProject.visibility = View.GONE
        layoutSuccess.visibility = View.VISIBLE
    }

    override fun displayTime(calendar: Calendar, selectedDate: Long): String {
        calendar.time = Date(selectedDate)
        return calendar.get(Calendar.YEAR).toString() + "-" + calendar.get(Calendar.MONTH)
                .toString() + "-" + calendar.get(Calendar.DAY_OF_MONTH).toString()
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

}