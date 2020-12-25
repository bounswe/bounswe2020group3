package com.bounswe2020group3.paperlayer.profile.user

import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.profile.ProfileContract
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class UserPresenter @Inject constructor(private val model: ProfileContract.Model): BasePresenter<UserContract.View>(), UserContract.Presenter {

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
                {
                    _ -> view?.showErrorToast("Some error occurred. Please try again")
                    view?.navigateBack()
                }
        )
        disposable.add(userSub)
    }

}