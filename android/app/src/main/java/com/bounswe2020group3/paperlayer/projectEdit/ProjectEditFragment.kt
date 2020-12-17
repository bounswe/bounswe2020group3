package com.bounswe2020group3.paperlayer.projectEdit

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.data.Project
import com.bounswe2020group3.paperlayer.projectCreate.ProjectState
import com.bounswe2020group3.paperlayer.projectCreate.ProjectType
import com.google.android.material.datepicker.MaterialDatePicker
import kotlinx.android.synthetic.main.fragment_project_edit.*
import kotlinx.android.synthetic.main.fragment_project_edit.buttonDatePicker
import kotlinx.android.synthetic.main.fragment_project_edit.editTextDescription
import kotlinx.android.synthetic.main.fragment_project_edit.editTextProjectName
import kotlinx.android.synthetic.main.fragment_project_edit.editTextRequirements
import kotlinx.android.synthetic.main.fragment_project_edit.layoutSuccess
import kotlinx.android.synthetic.main.fragment_project_edit.progressBar
import kotlinx.android.synthetic.main.fragment_project_edit.radioButtonNo
import kotlinx.android.synthetic.main.fragment_project_edit.radioButtonYes
import kotlinx.android.synthetic.main.fragment_project_edit.radioGroupIsPublic
import kotlinx.android.synthetic.main.fragment_project_edit.spinnerProjectState
import kotlinx.android.synthetic.main.fragment_project_edit.spinnerProjectType
import kotlinx.android.synthetic.main.fragment_project_edit.textViewDate
import timber.log.Timber
import java.util.*
import javax.inject.Inject

class ProjectEditFragment : Fragment(), ProjectEditContract.View {
    @Inject
    lateinit var presenter: ProjectEditContract.Presenter

    private var project: Project? = null

    companion object {
        const val project_key = "PROJECT"
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        presenter.bind(this)
        project = arguments?.getParcelable(project_key) as Project?

        return inflater.inflate(R.layout.fragment_project_edit, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        editTextProjectName.setText(project?.name)
        editTextDescription.setText(project?.description)
        editTextRequirements.setText(project?.requirements)

        radioGroupIsPublic.apply {
            when ( project?.is_public) {
                true -> check(radioButtonYes.id)
                false -> check(radioButtonNo.id)
            }
        }
        var isPublic = project?.is_public
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

        var projectState = ""
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

        ProjectState.fromString(project?.state ?: "")?.let {
            spinnerProjectState.setSelection(it.key)
        }

        val projectTypes = ProjectType.toList()
        val projectTypeAdapter =
                ArrayAdapter(requireContext(), R.layout.spinner_item, projectTypes)
        projectTypeAdapter.setDropDownViewResource(R.layout.spinner_item)
        spinnerProjectType.adapter = projectTypeAdapter

        var projectType = ""
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

        ProjectType.fromString(project?.project_type ?: "")?.let {
            spinnerProjectType.setSelection(it.key)
        }

        textViewDate.text = project?.due_date
        textViewDate.setTextColor(resources.getColor(R.color.colorBlack))

        val builder = MaterialDatePicker.Builder.datePicker()
        builder.setTitleText("Select a date")
        val datePicker = builder.build()
        val calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"))

        datePicker.addOnPositiveButtonClickListener {
            textViewDate.text = displayTime(calendar, it)
        }
        buttonDatePicker.setOnClickListener {
            datePicker.show(requireActivity().supportFragmentManager, "DATE_PICKER")
        }

        buttonEditProject.setOnClickListener {
            it.hideKeyboard()
            val projectEditRequest = ProjectEditRequest(
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
            if(project != null) {
                presenter.editProject(project!!.id, projectEditRequest)
            }

        }
        buttonDone.setOnClickListener {
            presenter.navigateToProjectDetail(project?.id)
        }

    }

    override fun showSuccess() {
        progressBar.visibility = View.GONE
        buttonEditProject.visibility = View.GONE
        layoutEditProject.visibility = View.GONE
        layoutSuccess.visibility = View.VISIBLE
    }



    override fun showToast(message: String) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }

    override fun displayTime(calendar: Calendar, selectedDate: Long): String {
        calendar.time = Date(selectedDate)
        return calendar.get(Calendar.YEAR).toString() + "-" + (calendar.get(Calendar.MONTH)+1).
        toString() + "-" + calendar.get(Calendar.DAY_OF_MONTH).toString()
    }

    private fun View.hideKeyboard() {
        val imm = context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(windowToken, 0)
    }

    override fun showProgress(show: Boolean) {
        if (show) {
            progressBar.visibility = View.VISIBLE
            buttonEditProject.isEnabled = false
        } else {
            progressBar.visibility = View.GONE
            buttonEditProject.isEnabled = true
        }
    }


}