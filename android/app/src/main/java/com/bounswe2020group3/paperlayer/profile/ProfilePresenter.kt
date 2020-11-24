package com.bounswe2020group3.paperlayer.profile

import android.util.Log
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class ProfilePresenter @Inject constructor(private var model: ProfileContract.Model) : BasePresenter<ProfileContract.View>(), ProfileContract.Presenter {

    private var disposable = CompositeDisposable()

    override fun bind(view: ProfileContract.View) {
        super.bind(view)
    }

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun subscribeUser() {
        val userProfileSub = model.getUser().subscribe(
                { user ->
                    view?.updateProfileUI(user)
                },
                {
                    error -> Log.d("Error", "Some error occured.")
                }
        )
        disposable.add(userProfileSub)
    }

    override fun loadUser() {
        view?.showLoading()
        try {
            val fetchSub = model.fetchUser().subscribe(
                    {
                        view?.hideLoading()
                    },
                    {
                        view?.hideLoading()
                        view?.showErrorToast("An error occurred while fetching profile. Please try again.")
                    }
            )
            disposable.add(fetchSub)
        } catch (e: Exception) {
            view?.showErrorToast("Please log in first.")
            view?.navigateToLogin()
        }
    }
}