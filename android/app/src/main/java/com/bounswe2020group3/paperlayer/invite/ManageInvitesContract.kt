package com.bounswe2020group3.paperlayer.invite

import androidx.recyclerview.widget.RecyclerView
import com.bounswe2020group3.paperlayer.mvp.Mvp

class ManageInvitesContract {
    interface Presenter: Mvp.Presenter<View> {
        fun setView(view: View)
        fun showMessage(message: String)

        fun subscribeAuthToken()
        fun fetchInvited(ownerId: Int)

        fun OnInviteButtonClicked(Item : InviteCard,position : Int)
    }

    interface View: Mvp.View{
        var projectId : Int
        var recyclerView : RecyclerView
        fun getLayout(): android.view.View
        fun showToast(message: String)
        fun writeLogMessage(type:String ,tag: String,message: String)

        fun cardInviteCheck(id : Int,position : Int)
        fun cardUnInviteCheck(id : Int,position : Int)
        fun resetUserCardlist()
        fun submitUserCardList()
        fun addUserCard(userId: Int, username: String,name : String,expertise: String?,photoURL: String?,id : Int,invited : Boolean)
    }
}