package com.bounswe2020group3.paperlayer.publication

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import com.bounswe2020group3.paperlayer.mvp.BasePresenter
import com.bounswe2020group3.paperlayer.project.ProjectCard
import com.bounswe2020group3.paperlayer.project.data.Tag
import io.reactivex.disposables.CompositeDisposable
import javax.inject.Inject


private const val TAG = "PublicationsPresenter"

class PublicationPresenter @Inject constructor(private var model: PublicationContract.Model):BasePresenter<PublicationContract.View>(),PublicationContract.Presenter{

    //Disposable
    private var disposable = CompositeDisposable()


    override fun bind(view: PublicationContract.View) {
        super.bind(view)
        this.view?.writeLogMessage("i", TAG, "Publication Presenter Created")
    }

    override fun unbind() {
        super.unbind()
        disposable.clear()
    }

    override fun setView(view: PublicationContract.View) {
        this.view =view
    }

    override fun showMessage(message: String) {
        this.view?.showToast(message)
    }

    override fun fetchAllPublicationsOfOwner(ownerId: Int) {
        this.view?.writeLogMessage("i", TAG, "Fetching all publications of owner $ownerId ...")
        val getPublicationObservable = model.getAllPublicationsOfOwner(ownerId).subscribe(
            { publicationList ->
                for (publication in publicationList) {
                    var emptyList = ArrayList<Tag>()
                    this.view?.addPublicationCard(publication.title, publication.link, publication.citationNumber.toString(), emptyList, publication.id)
                    this.view?.writeLogMessage("i", TAG, "Publication Fetched + " + publication.title + " ")
                }
                this.view?.writeLogMessage("i", TAG, "Fetching finished.")
                this.view?.submitPublicationCardList()
            },
            { error ->
                this.view?.writeLogMessage("e", TAG, "Error in fetching all publications of owner $ownerId $error")
                this.view?.showToast("Error in getting publications of this user.")
            }
        )
        disposable.add(getPublicationObservable)
    }

    override fun onViewPublicationButtonClicked(item: ProjectCard, position: Int) {
        try {
            //Navigating to publications page
            val url = item.projectBody
            val intent = Intent(Intent.ACTION_VIEW)
            intent.data = Uri.parse(url)
            this.view?.getMyContext()?.startActivity(intent)
        } catch (e: ActivityNotFoundException) {
            this.view?.showToast("Error in opening url")
        }
    }


}