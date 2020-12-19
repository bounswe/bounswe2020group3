package com.bounswe2020group3.paperlayer.projectEdit

import android.view.View
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import androidx.navigation.fragment.NavHostFragment.findNavController
import androidx.navigation.fragment.findNavController
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import io.reactivex.disposables.CompositeDisposable
import kotlinx.android.synthetic.main.activity_main.*
import timber.log.Timber
import javax.inject.Inject

class ProjectEditPresenter @Inject constructor(private var model: ProjectEditContract.Model) : BasePresenter<ProjectEditContract.View>(), ProjectEditContract.Presenter {
    private var disposable = CompositeDisposable()
    override fun editProject(projectID: Int, projectEditRequest: ProjectEditRequest) {
        view?.showProgress(true)
        val editProjectObservable = model.editProject(projectID, projectEditRequest).subscribe({
            view?.showProgress(false)
            view?.showSuccess()
            disposable.clear()
        }, {
            view?.showProgress(false)
            disposable.clear()
            view?.showToast("Error while editing project")
        })
        disposable.add(editProjectObservable)
    }

    override fun navigateToProjectDetail(projectID: Int?) {
        val bundle = bundleOf("projectID" to projectID )
        (view as Fragment).view?.let { Navigation.findNavController(it).navigate(R.id.navigateToProjectFragmentFromProjectEditFragment, bundle) }
    }
}