package com.bounswe2020group3.paperlayer.event

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.data.Event
import kotlinx.android.synthetic.main.fragment_event.*
import javax.inject.Inject

private const val ARG_EVENT_ID = "eventID"

/**
 * A simple [Fragment] subclass.
 * Use the [EventDetailFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class EventDetailFragment : Fragment(), EventDetailContract.View {
    private var eventID: Int? = null

    @Inject
    lateinit var presenter: EventDetailContract.Presenter

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            eventID = it.getInt(ARG_EVENT_ID)
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        presenter.bind(this)
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_event, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        if(eventID != null) {
            presenter.loadEvent(eventID!!)
        } else {
            showErrorToast("Invalid event. Please try again.")
            navigateBack()
        }
    }

    companion object {
        @JvmStatic
        fun newInstance(eventID: Int) =
                EventDetailFragment().apply {
                    arguments = Bundle().apply {
                        putInt(ARG_EVENT_ID, eventID)
                    }
                }
    }

    override fun showLoading() {
        progressBarEvent.visibility = View.VISIBLE
        layoutEventWrapper.visibility = View.GONE
    }

    override fun hideLoading() {
        progressBarEvent.visibility = View.GONE
        layoutEventWrapper.visibility = View.VISIBLE
    }

    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun updateEvent(event: Event) {
        showInfoToast(event.id.toString())
        textViewEventTitle.text = event.title
        textViewEventDescription.text = event.description
        textViewEventDeadline.text = event.deadline
        textViewEventDate.text = event.date
    }

    override fun navigateBack() {
        Navigation.findNavController(requireView()).navigateUp()
    }
}