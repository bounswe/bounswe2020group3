package com.bounswe2020group3.paperlayer.search


import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.AutoCompleteTextView
import android.widget.SearchView
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.project.data.Tag
import com.bounswe2020group3.paperlayer.project.tagColors
import com.bounswe2020group3.paperlayer.search.data.Search
import com.bounswe2020group3.paperlayer.search.data.TagList
import com.google.android.material.chip.Chip
import com.google.android.material.datepicker.MaterialDatePicker
import com.google.android.material.tabs.TabLayout
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.fragment_project_detail.*
import kotlinx.android.synthetic.main.fragment_project_detail.view.*
import kotlinx.android.synthetic.main.fragment_search.*
import kotlinx.android.synthetic.main.fragment_search.searchView
import kotlinx.android.synthetic.main.fragment_search_filter.*
import kotlinx.android.synthetic.main.fragment_search_filter.view.*
import kotlinx.android.synthetic.main.fragment_search_filter.view.chipGroupTags
import kotlinx.android.synthetic.main.layout_list_item_event.view.*

import javax.inject.Inject

private const val TAG = "AdvancedSearchFragment"

class AdvancedSearchFragment: Fragment(){


    //View object
    private lateinit var fragmentView: View

    //Tag List
    private lateinit var tagList: List<Tag>

    //Mapping chip to tag id
    private var chipIdToTagId= HashMap<Int, Int>()


    override fun onDestroy() {
        super.onDestroy()
        writeLogMessage("i", TAG,"Advanced Search Fragment destroyed.")
    }

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_search_filter, container, false)
        this.fragmentView = view
        writeLogMessage("i", TAG,"Advanced Search Fragment view created")
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        this.searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String): Boolean {
                searchSubmit(query)
                return false
            }

            override fun onQueryTextChange(p0: String?): Boolean {
                return false
            }

        })

        //Filling tags
        var tagsBundle: TagList? = arguments?.getParcelable("tags") as TagList?
        writeLogMessage("i", TAG, "Tag list size " + tagsBundle?.tags?.size)
        if(tagsBundle!=null) {
            tagList= tagsBundle?.tags!!
            initTagsGroup(tagList)
        }



        tabLayoutSearchFilter!!.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab) {
                searchView.setQuery("", false);
                searchView.clearFocus()
                when(tab.position){
                    0-> {
                        fragmentView.linearLayoutProjectSettings.visibility = View.VISIBLE
                        fragmentView.linearLayoutEventSettings.visibility=View.GONE
                        fragmentView.linearLayoutProfileSettings.visibility=View.GONE
                    }
                    1->{
                        fragmentView.linearLayoutProjectSettings.visibility = View.GONE
                        fragmentView.linearLayoutEventSettings.visibility=View.GONE
                        fragmentView.linearLayoutProfileSettings.visibility=View.VISIBLE
                    }
                    2->{
                        fragmentView.linearLayoutProjectSettings.visibility = View.GONE
                        fragmentView.linearLayoutEventSettings.visibility=View.VISIBLE
                        fragmentView.linearLayoutProfileSettings.visibility=View.GONE
                    }

                }

            }
            override fun onTabUnselected(tab: TabLayout.Tab) {

            }
            override fun onTabReselected(tab: TabLayout.Tab) {

            }
        })

        //initialize dropdown settings in filters
        initProjectStateDropdown()
        initEventTypeDropdown()

        this.fragmentView.buttonSearch.setOnClickListener {
            onSearchButtonClicked(this.searchView.query.toString());
        }


    }

   fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    private fun initProjectStateDropdown(){
        val items = listOf("Draft", "inviting collaborators", "open for collaborators", "in progress","submitted to event","published","cancelled","done","reopened","")
        val adapter = ArrayAdapter(requireContext(), R.layout.layout_list_item_search_filter_dropdown, items)
        (fragmentView.menuProjectState.editText as? AutoCompleteTextView)?.setAdapter(adapter)
    }

    private fun initEventTypeDropdown(){
        val items = listOf("journal submission", "academic conference", "funded project","")
        val adapter = ArrayAdapter(requireContext(), R.layout.layout_list_item_search_filter_dropdown, items)
        (fragmentView.menuEventType.editText as? AutoCompleteTextView)?.setAdapter(adapter)
    }

   fun writeLogMessage(type:String ,tag: String,message: String) {
        when(type){
            "e"-> Log.e(tag,message) //error
            "w"-> Log.w(tag,message) //warning
            "i"-> Log.i(tag,message) //information
            "d"-> Log.d(tag,message) //debug
            "v"-> Log.v(tag,message) //verbose
            else-> Log.e(tag,"Type is not defined")
        }
    }

    private fun searchSubmit(keyword:String){
        writeLogMessage("i", TAG,"Advanced Search : $keyword submitted .")
        onSearchButtonClicked(keyword)
    }

    private fun onSearchButtonClicked(keyword:String){
        writeLogMessage("i", TAG,"Advanced Search : $keyword submitted .")
        val checkedChipIds = fragmentView.chipGroupTags.checkedChipIds
        writeLogMessage("i",TAG,"Chips "+ checkedChipIds.size)
        when(this.tabLayoutSearchFilter.selectedTabPosition){
            0->{//Project Tab selected
                var projectDueDateAfter: String? = this.fragmentView.editTextProjectDueDateAfter.editText?.text.toString()
                var projectDueDateBefore: String? = this.fragmentView.editTextProjectDueDateBefore.editText?.text.toString()
                var projectEvent:String?= this.fragmentView.editTextProjectEvent.editText?.text.toString()
                var projectState:String? =this.fragmentView.autoCompleteTextViewProjectState.text.toString()
                var projectTags:List<Int>? = this.fragmentView.chipGroupTags.checkedChipIds
                if(projectDueDateAfter=="")
                    projectDueDateAfter=null
                if(projectDueDateBefore=="")
                    projectDueDateBefore=null
                if(projectEvent=="")
                    projectEvent=null
                if(projectState=="")
                    projectState= null
                if (projectTags != null) {
                    if(projectTags.isEmpty())
                        projectTags=null

                }
                var searchFilter = Search(keyword,"project",null,null,null,
                        null,null,null,null,projectDueDateAfter,projectDueDateBefore,projectEvent,projectState,projectTags) //fix
                val bundle = Bundle()
                bundle.putParcelable("searchFilter", searchFilter)
                Navigation.findNavController(requireView()).navigate(R.id.navigateToSearchFromAdvancedSearch, bundle)

            }
            1->{//Profile Tab selected
                var profileAffiliations: String? = this.fragmentView.editTextProfileAffiliations.editText?.text.toString()
                var profileExpertise: String? = this.fragmentView.editTextProfileExpertise.editText?.text.toString()
                if(profileAffiliations=="")
                    profileAffiliations=null
                if(profileExpertise=="")
                    profileExpertise=null
                var searchFilter = Search(keyword,"profile",profileAffiliations,profileExpertise,null,
                        null,null,null,null,null,null,null,null,null)
                val bundle = Bundle()
                bundle.putParcelable("searchFilter", searchFilter)
                Navigation.findNavController(requireView()).navigate(R.id.navigateToSearchFromAdvancedSearch, bundle)
            }
            2->{//Event Tab selected
                var eventDateAfter: String? = this.fragmentView.editTextEventDateAfter.editText?.text.toString()
                var eventDateBefore: String? = this.fragmentView.editTextEventDateBefore.editText?.text.toString()
                var eventDeadlineDateAfter: String? = this.fragmentView.editTextEventDeadlineDateAfter.editText?.text.toString()
                var eventDeadlineDateBefore: String? = this.fragmentView.editTextEventDeadlineDateBefore.editText?.text.toString()
                var eventType:String?= this.fragmentView.autoCompleteTextViewEventType.text.toString()

                if(eventDateAfter=="")
                    eventDateAfter=null
                if(eventDateBefore=="")
                    eventDateBefore=null
                if(eventDeadlineDateAfter=="")
                    eventDeadlineDateAfter=null
                if(eventDeadlineDateBefore=="")
                    eventDeadlineDateBefore= null
                if(eventType=="")
                    eventType=null


                var searchFilter = Search(keyword,"event",null,null,eventDateAfter,
                        eventDateBefore,eventDeadlineDateAfter,eventDeadlineDateBefore,eventType,null,null,null,null,null)
                val bundle = Bundle()
                bundle.putParcelable("searchFilter", searchFilter)
                Navigation.findNavController(requireView()).navigate(R.id.navigateToSearchFromAdvancedSearch, bundle)
            }
        }

    }

    private fun initTagsGroup(tagList: List<Tag>){

        //Adding tags to dynamically to project tags
        if (this.fragmentView.chipGroupTags?.childCount != tagList.size) {
            for (tag in tagList){
                val chip = Chip(this.fragmentView.chipGroupTags.context)
                chip.text=tag.name
                chip.id=tag.id
                chip.isCheckable=true
                chip.setChipBackgroundColorResource(tagColors[tag.color])
                this.fragmentView.chipGroupTags.addView(chip)
            }
        }
    }











}