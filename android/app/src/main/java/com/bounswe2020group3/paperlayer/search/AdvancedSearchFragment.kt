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
import androidx.fragment.app.Fragment
import com.bounswe2020group3.paperlayer.R
import com.google.android.material.datepicker.MaterialDatePicker
import com.google.android.material.tabs.TabLayout
import kotlinx.android.synthetic.main.fragment_search.searchView
import kotlinx.android.synthetic.main.fragment_search_filter.*
import kotlinx.android.synthetic.main.fragment_search_filter.view.*

import javax.inject.Inject

private const val TAG = "AdvancedSearchFragment"

class AdvancedSearchFragment: Fragment(){


    //View object
    private lateinit var fragmentView: View


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

        tabLayoutSearchFilter!!.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab) {
                searchView.setQuery("", false);
                searchView.clearFocus()
            }
            override fun onTabUnselected(tab: TabLayout.Tab) {

            }
            override fun onTabReselected(tab: TabLayout.Tab) {

            }
        })

        initProjectStateDropdown()

    }

   fun showToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    private fun initProjectStateDropdown(){
        val items = listOf("Draft", "inviting collaborators", "open for collaborators", "in progress","submitted to event","published","cancelled","done","reopened","")
        val adapter = ArrayAdapter(requireContext(), R.layout.layout_list_item_search_filter_dropdown, items)
        (fragmentView.menuProjectState.editText as? AutoCompleteTextView)?.setAdapter(adapter)
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
        writeLogMessage("i", TAG,"Search : $keyword submitted .")

    }












}