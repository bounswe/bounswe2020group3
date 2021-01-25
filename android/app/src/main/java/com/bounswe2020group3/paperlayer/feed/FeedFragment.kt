package com.bounswe2020group3.paperlayer.feed

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.feed.data.Feed
import com.bounswe2020group3.paperlayer.feed.data.FeedType
import kotlinx.android.synthetic.main.fragment_feed.*
import javax.inject.Inject

class FeedFragment : Fragment(), FeedContract.View {

    @Inject
    lateinit var presenter: FeedContract.Presenter

    private var feedAdapter: FeedAdapter = FeedAdapter(listOf())

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {

        return inflater.inflate(R.layout.fragment_feed, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        presenter.bind(this)
        initRecyclerView()
        presenter.fetchFeedTimeline()
    }

    override fun showProgress(show: Boolean) {
        if (show) {
            progressBar?.visibility = View.VISIBLE
        }
        else {
            progressBar?.visibility = View.GONE
        }
    }

    override fun showToast(message: String) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }

    private fun initRecyclerView(){
        recyclerViewFeed.layoutManager = LinearLayoutManager(context)
        recyclerViewFeed.adapter = feedAdapter
        recyclerViewFeed.setHasFixedSize(true)
        feedAdapter.onFeedItemClick = {
            when(it.feedType) {
                FeedType.EVENT -> {
                    it.event?.id?.let { eventId ->
                        val bundle = bundleOf("eventID" to eventId)
                        Navigation.findNavController(requireView()).navigate(R.id.eventDetailFragment, bundle)
                    }
                }
                FeedType.PROJECT -> {
                    it.project?.id?.let { projectId ->
                        val bundle = bundleOf("projectID" to projectId )
                        Navigation.findNavController(requireView()).navigate(R.id.projectFragment, bundle)
                    }
                }
                FeedType.FOLLOW -> {
                    it.follow?.to_user?.let { to_user ->
                        val bundle = bundleOf("userID" to to_user.id )
                        Navigation.findNavController(requireView()).navigate(R.id.userFragment, bundle)
                    }
                }
                FeedType.RATING -> {
                    it.rating?.to_user?.let { to_user ->
                        val bundle = bundleOf("userID" to to_user.id )
                        Navigation.findNavController(requireView()).navigate(R.id.userFragment, bundle)
                    }
                }
                FeedType.COMMENT -> {
                    it.comment?.to_user?.let { to_user ->
                        val bundle = bundleOf("userID" to to_user.id )
                        Navigation.findNavController(requireView()).navigate(R.id.userFragment, bundle)
                    }
                }
            }
        }

    }

    override fun setupRecyclerViewItems(feedList: List<Feed>){
        feedAdapter.feedItems = feedList
        feedAdapter.notifyDataSetChanged()
    }

}