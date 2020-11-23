package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import dagger.Module
import dagger.Provides
import retrofit2.Retrofit
import javax.inject.Singleton

@Module
class NetworkModule {

    @Provides
    @Singleton
    fun provideRetrofit(): Retrofit = RetrofitProvider.instance
}