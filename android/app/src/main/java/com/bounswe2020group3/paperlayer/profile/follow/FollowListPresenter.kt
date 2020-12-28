package com.bounswe2020group3.paperlayer.profile.follow

import android.util.Log
import com.bounswe2020group3.paperlayer.data.follow.ListableFollow
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
        val followListObservable = when (type) {
            FollowType.FOLLOWER -> {
                followModel.getFollowerList(userId)
            }
            FollowType.FOLLOWING -> {
                followModel.getFollowingList(userId)
            }
            else -> {
                followModel.getFollowRequestList()
            }
        }

        val followListSub = followListObservable.subscribe(
                { followList ->
                    view?.updateFollowListUI(followList as List<ListableFollow>)
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

    override fun sendFollow(toUserId: Int) {
        val followSub = followModel.sendFollow(toUserId).subscribe(
                { _ ->
                    view?.showInfoToast("User is followed")
                    view?.loadList()
                },
                { _ ->
                    view?.showErrorToast("Some error occurred. Please try again")
                }
        )
        disposable.add(followSub)
    }

    override fun sendFollowRequest(toUserId: Int) {
        val followRequestSub = followModel.sendFollowRequest(toUserId).subscribe(
                { _ ->
                    view?.showInfoToast("Follow request sent successfully")
                    view?.loadList()
                },
                { _ ->
                    view?.showErrorToast("Some error occurred. Please try again")
                }
        )
        disposable.add(followRequestSub)
    }

    override fun sendUnfollow(followId: Int) {
        val followRequestSub = followModel.sendUnfollow(followId).subscribe(
                { _ ->
                    view?.showInfoToast("User is unfollowed")
                    view?.loadList()
                },
                { _ ->
                    view?.showErrorToast("Some error occurred. Please try again")
                }
        )
        disposable.add(followRequestSub)
    }

    override fun acceptRequest(requestId: Int, fromUserId: Int) {
        val acceptSub = followModel.acceptFollowRequest(requestId, fromUserId).subscribe(
                { _ ->
                    view?.showInfoToast("Follow request is accepted")
                    view?.loadList()
                },
                { _ ->
                    view?.showErrorToast("Some error occurred. Please try again")
                }
        )
        disposable.add(acceptSub)
    }

    override fun rejectRequest(requestId: Int, fromUserId: Int) {
        val rejectSub = followModel.rejectFollowRequest(requestId, fromUserId).subscribe(
                { _ ->
                    view?.showInfoToast("Follow request is rejected")
                    view?.loadList()
                },
                { _ ->
                    view?.showErrorToast("Some error occurred. Please try again")
                }
        )
        disposable.add(rejectSub)
    }

}