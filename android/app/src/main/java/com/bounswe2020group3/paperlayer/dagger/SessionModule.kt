package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.util.Session
import com.bounswe2020group3.paperlayer.util.SessionManager
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class SessionModule {

    @Binds
    @Singleton
    abstract fun bindSession(sessionManager: SessionManager): Session
}