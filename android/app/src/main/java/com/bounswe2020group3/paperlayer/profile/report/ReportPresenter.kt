package com.bounswe2020group3.paperlayer.profile.report

import com.bounswe2020group3.paperlayer.data.user.Report
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.profile.ProfileContract
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject

class ReportPresenter @Inject constructor(
    private val profileModel: ProfileContract.Model
) : BasePresenter<ReportContract.View>(), ReportContract.Presenter {

    private var disposable = CompositeDisposable()

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun sendReport(type: String, userId: Int, description: String?) {
        val reportSub =  profileModel.reportUser(Report(type, description, userId)).subscribe(
            {
                view?.showInfoToast("User is reported.")
                view?.navigateBack()
            },
            {
                view?.showErrorToast("An error occurred while reporting the user. Please try again.")
            }
        )
        disposable.add(reportSub);
    }
}