package com.bounswe2020group3.paperlayer.register

import com.bounswe2020group3.paperlayer.base.BasePresenter
import com.bounswe2020group3.paperlayer.base.BaseView
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.register.data.Register
import io.reactivex.Single
import retrofit2.Call
import retrofit2.http.*

interface RegisterContract {
    interface Presenter : BasePresenter {
        fun onViewCreated()
        fun register(register : Register)
    }

    interface View : BaseView<Presenter> {
        fun showLoading()
        fun hideLoading()
        fun navigateToLogin()
        fun showInfoToast(message: String = "Info")
        fun showErrorToast(message: String = "Error")
        fun showToast(message: String)
    }



    interface Model {
        fun register(register : Register): Call<Register>
    }

    interface RegisterService {
        @POST("/api/register/")
        @FormUrlEncoded
        fun register(@Body register : Register): Call<Register>
    }
}