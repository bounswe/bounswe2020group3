package com.bounswe2020group3.paperlayer.profile.user

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.follow.FollowModel
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class UserPresenter @Inject constructor(
    private val model: ProfileContract.Model,
    private val followModel: FollowModel
) : BasePresenter<UserContract.View>(), UserContract.Presenter {

    private var disposable = CompositeDisposable()

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun loadUser(userId: Int) {
        view?.showLoading()
        val userSub = model.getUser(userId).subscribe(
            { user ->
                view?.updateProfileUI(user)
                view?.hideLoading()
            },
            { _ ->
                view?.showErrorToast("Some error occurred. Please try again")
                view?.navigateBack()
            }
        )
        disposable.add(userSub)
    }

    override fun sendFollow(toUserId: Int) {
        val followSub = followModel.sendFollow(toUserId).subscribe(
            { _ ->
                view?.showInfoToast("Follow sent successfully")
                view?.loadUser()
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
                view?.loadUser()
            },
            { _ ->
                view?.showErrorToast("Some error occurred. Please try again")
            }
        )
        disposable.add(followRequestSub)
    }
}