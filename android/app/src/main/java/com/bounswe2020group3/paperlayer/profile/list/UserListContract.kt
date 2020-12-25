package com.bounswe2020group3.paperlayer.profile.list

import com.bounswe2020group3.paperlayer.mvp.Mvp
import com.bounswe2020group3.paperlayer.profile.data.User

interface UserListContract {
    interface Presenter: Mvp.Presenter<View> {
        fun loadUserList()
    }

    interface View: Mvp.View{
        fun updateUserListUI(userList: List<User>)
        fun navigateToUser()
    }
}