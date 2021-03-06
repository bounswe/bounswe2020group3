package com.bounswe2020group3.paperlayer.search

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Parcelable
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.View.GONE
import android.view.View.VISIBLE
import android.view.ViewGroup
import android.widget.SearchView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.data.Tag
import com.bounswe2020group3.paperlayer.search.data.Search
import com.bounswe2020group3.paperlayer.search.data.TagList
import com.google.android.material.tabs.TabLayout
import kotlinx.android.synthetic.main.fragment_search.*
import javax.inject.Inject


private const val TAG = "SearchFragment"

class SearchFragment: Fragment(),SearchContract.View ,OnCardClickListener{

    //Presenter object
    @Inject
    lateinit var presenter: SearchPresenter

    //View object
    private lateinit var fragmentView: View

    //Adapter object
    private lateinit var searchAdapter: SearchAdapter

    private lateinit var recyclerView: RecyclerView


    //Tag List
    private lateinit var tagList: List<Tag>

    //Search Card List
    private val searchCardList=ArrayList<SearchCard>()

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        this.presenter.unbind()
        resetSearchCardList()
        writeLogMessage("i", TAG, "SearchFragment destroyed.")
    }

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_search, container, false)
        this.fragmentView = view
        writeLogMessage("i", TAG, "Search Fragment view created")
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        //Set ProjectPresenter view to project fragment
        this.presenter.setView(this)
        this.presenter.bind(this)
        initRecyclerView()
        resetSearchCardList()
        this.presenter.getTags()//getting tags that used in search filter


        this.searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String): Boolean {
                searchSubmit(query)
                return false
            }

            override fun onQueryTextChange(p0: String?): Boolean {
                return false
            }
        })
        //ADVANCED SEARCH
        var searchFilterBundle: Search? = arguments?.getParcelable("searchFilter") as Search?
        writeLogMessage("i", TAG, "search " + searchFilterBundle?.projectDueDateBefore)
        if(searchFilterBundle!=null){
            when(searchFilterBundle.searchType){
                "project" -> {
                    val tab: TabLayout.Tab? = tabLayoutSearch.getTabAt(0)
                    tab?.select()
                }
                "profile" -> {
                    val tab: TabLayout.Tab? = tabLayoutSearch.getTabAt(1)
                    tab?.select()
                }
                "event" -> {
                    val tab: TabLayout.Tab? = tabLayoutSearch.getTabAt(2)
                    tab?.select()
                }
            }
            showLoading()
            advancedSearchSubmit(searchFilterBundle)
        }
        //ADVANCED SEARCH
        tabLayoutSearch!!.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab) {
                searchView.setQuery("", false);
                searchView.clearFocus()
                resetSearchCardList()
            }

            override fun onTabUnselected(tab: TabLayout.Tab) {

            }

            override fun onTabReselected(tab: TabLayout.Tab) {

            }
        })

        //Advanced Search Button Click Listener
        this.buttonAdvancedSearch.setOnClickListener {
            val bundle = Bundle()
            val tagListC= TagList(tagList);
            bundle.putParcelable("tags", tagListC)
            writeLogMessage("i", TAG, "Before sending " + tagList.size)
            Navigation.findNavController(requireView()).navigate(R.id.navigateToAdvancedSearchFragmentFromSearch, bundle)
        }

    }

    override fun getLayout(): View {
        return this.fragmentView
    }

    override fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun writeLogMessage(type: String, tag: String, message: String) {
        when(type){
            "e" -> Log.e(tag, message) //error
            "w" -> Log.w(tag, message) //warning
            "i" -> Log.i(tag, message) //information
            "d" -> Log.d(tag, message) //debug
            "v" -> Log.v(tag, message) //verbose
            else-> Log.e(tag, "Type is not defined")
        }
    }

    override fun resetSearchCardList() {
        searchCardList.clear()
        searchAdapter.submitList(this.searchCardList)
        searchAdapter.notifyDataSetChanged() //notify to update recyclerview
    }

    override fun submitSearchCardList() {
        searchAdapter.submitList(this.searchCardList)
        searchAdapter.notifyDataSetChanged() //notify to update recyclerview
        if(searchCardList.size==0)
            this.showToast("No results were found")
        writeLogMessage("i", TAG, "Search Card List Updated! " + searchCardList.size)
    }

    override fun addSearchCard(searchType: Int, titleIconType: Int, title: String, body: String, supportText: String, tags: List<Tag>, id: Int) {
        searchCardList.add(
                SearchCard(searchType, titleIconType, title, body, supportText, tags, id))
        writeLogMessage("i", TAG, "Project Card Added! Type: $searchType Title: $title ${tags.size}")
    }

    private fun initRecyclerView(){
        this.recyclerView= fragmentView.findViewById(R.id.recyclerViewSearch)!!
        this.recyclerView.layoutManager= LinearLayoutManager(this.context)
        this.searchAdapter= SearchAdapter(this)
        this.recyclerView.adapter=searchAdapter
        writeLogMessage("i", TAG, "RecyclerView initialized.")
    }


    private fun searchSubmit(keyword: String){
        writeLogMessage("i", TAG, "Search : $keyword submitted .")
        resetSearchCardList()
        showLoading()
        when(this.tabLayoutSearch.selectedTabPosition){
            0 -> {//Project Tab selected
                var searchFilter = Search(keyword, "project", null, null, null,
                        null, null, null, null, null, null, null, null,null)
                this.presenter.searchRequest(searchFilter)
            }
            1 -> {//Profile Tab selected
                var searchFilter = Search(keyword, "profile", null, null, null,
                        null, null, null, null, null, null, null, null,null)
                this.presenter.searchRequest(searchFilter)
            }
            2 -> {//Event Tab selected
                var searchFilter = Search(keyword, "event", null, null, null,
                        null, null, null, null, null, null, null, null,null)
                this.presenter.searchRequest(searchFilter)
            }
        }
    }

    private fun advancedSearchSubmit(searchFilter: Search){
        writeLogMessage("i", TAG, " Search Filter Settings " + searchFilter.searchType + " " + searchFilter.keyword + " " + searchFilter.projectDueDateBefore + " ")
        this.presenter.searchRequest(searchFilter)
    }

    override fun setTags(tags: List<Tag>){
        writeLogMessage("i", TAG, "Size " + tags.size)
        tagList=tags
    }

    override fun onSearchCardClick(item: SearchCard, position: Int) {
        when(item.searchType){
            0 -> {//project
                this.presenter.onProjectClicked(item, position)
            }
            1 -> {//user
                this.presenter.onUserClicked(item, position)
            }
            2 -> {//event
                this.presenter.onEventClicked(item, position)
            }
        }
    }

    override fun hideLoading()
    {
        this.progressIndicatorSearch.visibility=GONE
    }

    override fun showLoading()
    {
        this.progressIndicatorSearch.visibility= VISIBLE
    }


}

