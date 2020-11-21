package com.bounswe2020group3.paperlayer.profile.common

import io.reactivex.disposables.CompositeDisposable

open class ProfileCommonPresenter(view: ProfileCommonContract.View) : ProfileCommonContract.Presenter {

    private var view: ProfileCommonContract.View? = view
    private var model: ProfileCommonContract.Model = ProfileCommonModel()

    private var disposable = CompositeDisposable()

    open fun onDestroy() {
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