package com.bounswe2020group3.paperlayer.profile

import android.util.Log
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class ProfilePresenter @Inject constructor(private var model: ProfileContract.Model) : BasePresenter<ProfileContract.View>(), ProfileContract.Presenter {

    private var disposable = CompositeDisposable()

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun subscribeUserProfile() {
        val userProfileSub = model.getUserProfile().subscribe { profile ->
            view?.updateProfileUI(profile)
        }
        disposable.add(userProfileSub)
    }

    override fun loadUserProfile() {
        Log.d("Dagger", "Profile Presenter: $model")
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
}