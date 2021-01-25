package com.bounswe2020group3.paperlayer.publication

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.*
import com.bounswe2020group3.paperlayer.project.data.Publication
import com.bounswe2020group3.paperlayer.project.data.Tag
import javax.inject.Inject


private const val TAG = "PublicationFragment"

class PublicationFragment : Fragment(),PublicationContract.View , OnCardPublicationClickListener {

    //Presenter object
    @Inject
    lateinit var presenter: PublicationPresenter

    //View object
    private lateinit var fragmentView: View

    //Adapter Object
    private lateinit var publicationAdapter: PublicationAdapter

    // Declare Context variable at class level in Fragment
    private lateinit var mContext: Context
    private lateinit var recyclerViewPublications: RecyclerView

    //Publications Card List
    private val publicationsCardList= ArrayList<ProjectCard>()

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
        mContext = context
    }

    override fun onDestroy() {
        super.onDestroy()
        resetPublicationCardList()
        this.presenter.unbind()
        writeLogMessage("i", TAG, "Publication Fragment destroyed.")
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_publication, container, false)
        this.fragmentView = view
        writeLogMessage("i", TAG, "Publication Fragment view created")
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initRecyclerView()
        resetPublicationCardList()
        this.presenter.bind(this)
        //Get publications of given authorID
        val authorID = arguments?.getInt("authorID")
        if (authorID!= null) {
            this.presenter.fetchAllPublicationsOfOwner(authorID)
            writeLogMessage("i",TAG, "Author id $authorID")
        }
        else{
            writeLogMessage("e", TAG,"authorID null")
        }
    }


    private fun initRecyclerView() {
        this.recyclerViewPublications=fragmentView.findViewById(R.id.recyclerViewPublications)!!
        this.recyclerViewPublications.layoutManager= LinearLayoutManager(this.context)
        this.publicationAdapter= PublicationAdapter(this)
        this.recyclerViewPublications.adapter=publicationAdapter

        writeLogMessage("i", TAG, "RecyclerView initialized.")
    }

    override fun onViewPublicationButtonClick(item: ProjectCard, position: Int) {
       this.presenter.onViewPublicationButtonClicked(item,position)
    }

    override fun getLayout(): View {
        return this.fragmentView
    }

    override fun getMyContext(): Context {
        return this.mContext
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun writeLogMessage(type: String, tag: String, message: String) {
        when (type) {
            "e" -> Log.e(tag, message) //error
            "w" -> Log.w(tag, message) //warning
            "i" -> Log.i(tag, message) //information
            "d" -> Log.d(tag, message) //debug
            "v" -> Log.v(tag, message) //verbose
            else -> Log.e(tag, "Type is not defined")
        }
    }

    override fun resetPublicationCardList() {
        publicationsCardList.clear()
        publicationAdapter.submitList(this.publicationsCardList)
        publicationAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun submitPublicationCardList() {
        publicationAdapter.submitList(this.publicationsCardList)
        publicationAdapter.notifyDataSetChanged() //notify to update recyclerview
        if(publicationsCardList.size==0)
            this.showToast("No results were found")
        writeLogMessage("i", TAG, "Publication Card List Updated! " + publicationsCardList.size)
    }

    override fun addPublicationCard(publicationTitle: String, publicationAbstract: String, publicationAuthors: String, tags: List<Tag>, publicationID: Int) {
        publicationsCardList.add(
            ProjectCard(publicationTitle,
                publicationAbstract,
                publicationAuthors, publicationID,tags,"Publication"))
        writeLogMessage("i", TAG, "Publication Card Added $publicationTitle ")
    }














}