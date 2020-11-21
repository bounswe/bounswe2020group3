package com.bounswe2020group3.paperlayer.profile

import android.util.Log
import io.reactivex.disposables.CompositeDisposable

class ProfilePresenter(view: ProfileContract.View): ProfileContract.Presenter {

    private var view: ProfileContract.View? = view
    private var model: ProfileContract.Model = ProfileModel()

    private var disposable = CompositeDisposable()

    override fun subscribeUserProfile() {
        val userProfileSub = model.getUserProfile().subscribe{ profile ->
            view?.updateProfileUI(profile)
        }
        disposable.add(userProfileSub)
    }

    override fun loadUserProfile() {
        view?.showLoading()
        val fetchSub = model.fetchUserProfile().subscribe(
                {
                    view?.hideLoading()
                },
                {
                    view?.hideLoading()
                    view?.showErrorToast("An error occurred while fetching profile. Please try again.")
                }
        )
        disposable.add(fetchSub)
    }

    override fun onDestroy() {
        this.view = null
        disposable.clear()
    }

}