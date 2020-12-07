package com.bounswe2020group3.paperlayer.register

import android.widget.Toast
import com.bounswe2020group3.paperlayer.network.RetrofitProvider

import com.bounswe2020group3.paperlayer.profile.ProfileContract
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.register.data.Register
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import javax.inject.Inject

class RegisterModel @Inject constructor():RegisterContract.Model {

    private var registerService: RegisterContract.RegisterService = RetrofitProvider.instance.create(RegisterContract.RegisterService::class.java)


    override fun register(register: Register): Single<Register> {
        return registerService.register(register)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())



    }

}