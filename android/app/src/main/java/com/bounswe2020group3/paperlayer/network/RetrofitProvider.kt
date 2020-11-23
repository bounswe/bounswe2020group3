package com.bounswe2020group3.paperlayer.network

import com.bounswe2020group3.paperlayer.util.BASE_URL
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory


class RetrofitProvider {
    companion object {

        var client: OkHttpClient = OkHttpClient.Builder()
            .build()

        val instance: Retrofit = Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .addConverterFactory(MoshiConverterFactory.create())
            .client(client)
            .build()
    }
}