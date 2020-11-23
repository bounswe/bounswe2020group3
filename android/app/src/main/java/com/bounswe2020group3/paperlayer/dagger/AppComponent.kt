package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.login.LoginFragment
import com.bounswe2020group3.paperlayer.profile.ProfileFragment
import com.bounswe2020group3.paperlayer.profile.edit.ProfileEditFragment
import dagger.Component
import javax.inject.Singleton

@Component(modules = [NetworkModule::class, ProfileModule::class, LoginModule::class])
@Singleton
interface AppComponent {
    fun inject(fragment: ProfileFragment)
    fun inject(fragment: ProfileEditFragment)
    fun inject(fragment: LoginFragment)
}