package com.bounswe2020group3.paperlayer.network

import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import com.bounswe2020group3.paperlayer.util.BASE_URL

class RetrofitProvider {
    companion object {
        val instance: Retrofit = Retrofit.Builder()
            .baseUrl(BASE_URL)
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .addConverterFactory(MoshiConverterFactory.create())
                .build()
    }
}