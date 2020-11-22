package com.bounswe2020group3.paperlayer

import android.app.Application
import com.bounswe2020group3.paperlayer.dagger.AppComponent

class InitApplication: Application() {

    private lateinit var appComponent: AppComponent

    override fun onCreate() {
        super.onCreate()
    }
}