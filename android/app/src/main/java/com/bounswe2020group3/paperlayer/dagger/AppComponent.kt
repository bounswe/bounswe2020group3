package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.invite.InviteFragment
import com.bounswe2020group3.paperlayer.login.LoginFragment
import com.bounswe2020group3.paperlayer.profile.ProfileFragment
import com.bounswe2020group3.paperlayer.profile.edit.ProfileEditFragment
import com.bounswe2020group3.paperlayer.project.ProjectFragment
import com.bounswe2020group3.paperlayer.project.ProjectMainFragment
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateFragment
import dagger.Component
import javax.inject.Singleton

@Component(modules = [InviteModule::class,NetworkModule::class, ProfileModule::class, LoginModule::class,ProjectModule::class, SessionModule::class, ProjectCreateModule::class])
@Singleton
interface AppComponent {
    fun inject(fragment: ProfileFragment)
    fun inject(fragment: ProfileEditFragment)
    fun inject(fragment: LoginFragment)
    fun inject(fragment: ProjectMainFragment)
    fun inject(fragment: ProjectFragment)
    fun inject(fragment: ProjectCreateFragment)
    fun inject(fragment: InviteFragment)
}