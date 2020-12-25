package com.bounswe2020group3.paperlayer.profile.follow

import android.util.Log
import com.bounswe2020group3.paperlayer.data.follow.FollowType
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class FollowListPresenter @Inject constructor(private val followModel: FollowModel) :
    BasePresenter<FollowContract.View>(), FollowContract.Presenter {

    private var disposable = CompositeDisposable()

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun loadFollowList(userId: Int?, type: FollowType?) {
        val followListObservable = if (type == FollowType.FOLLOWER) {
            followModel.getFollowerList(userId)
        } else {
            followModel.getFollowingList(userId)
        }

        val followListSub = followListObservable.subscribe(
            { followList ->
                view?.updateFollowListUI(followList)
            },
            { error ->
                Log.d("Error", "Error occured while fetching follow list.")
            }
        )
        disposable.add(followListSub)
    }

    override fun isUserAuthenticatedUser(userId: Int): Boolean {
        return followModel.getAuthToken().id == userId
    }

}