package com.bounswe2020group3.paperlayer.profile.list

import android.util.Log
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.ProfileModel
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class UserListPresenter @Inject constructor(private val profileModel: ProfileModel): BasePresenter<UserListContract.View> (), UserListContract.Presenter {

    private var disposable = CompositeDisposable()

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun loadUserList() {
        val userListSub = profileModel.getUserList().subscribe(
            { userList ->
                Log.d("Test", "User list $userList")
                view?.updateUserListUI(userList)
            },
            { error -> Log.d("Error", "Error occured while fetching user list.")}
        )
        disposable.add(userListSub)
    }

}