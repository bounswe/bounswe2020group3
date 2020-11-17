package com.bounswe2020group3.paperlayer.profile

import android.util.Log
import io.reactivex.disposables.CompositeDisposable

class ProfilePresenter(view: ProfileContract.View) : ProfileContract.Presenter {

    private var view: ProfileContract.View? = view
    private var model: ProfileContract.Model = ProfileModel()

    private var disposable = CompositeDisposable()

    override fun onDestroy() {
        this.view = null
        disposable.clear()
    }

    override fun fetchProfile(profileId: Int) {
        view?.showLoading()
        view?.showInfoToast("Fetching the profile...")
        val getProfileObservable = model.getProfile(profileId).subscribe(
                { profile ->
                    view?.updateProfileUI(profile)
                    view?.hideLoading()
                    view?.showInfoToast("Profile is fetched.")
                },
                { error ->
                    view?.hideLoading()
                    view?.showErrorToast("Error while fetching profile")
                }
        )
        disposable.add(getProfileObservable)
    }

}