package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.event.EventDetailFragment
import com.bounswe2020group3.paperlayer.home.EventFragment
import com.bounswe2020group3.paperlayer.home.MilestoneFragment
import com.bounswe2020group3.paperlayer.home.RecentProjectsFragment
import com.bounswe2020group3.paperlayer.invite.InviteFragment
import com.bounswe2020group3.paperlayer.login.LoginFragment
import com.bounswe2020group3.paperlayer.profile.ProfileFragment
import com.bounswe2020group3.paperlayer.profile.edit.ProfileEditFragment
import com.bounswe2020group3.paperlayer.profile.follow.FollowListFragment
import com.bounswe2020group3.paperlayer.profile.list.UserListFragment
import com.bounswe2020group3.paperlayer.profile.user.UserFragment
import com.bounswe2020group3.paperlayer.project.ProjectDetailFragment
import com.bounswe2020group3.paperlayer.project.ProjectsFragment
import com.bounswe2020group3.paperlayer.projectCreate.ProjectCreateFragment
import com.bounswe2020group3.paperlayer.projectEdit.ProjectEditFragment
import com.bounswe2020group3.paperlayer.register.RegisterFragment
import com.bounswe2020group3.paperlayer.search.SearchFragment
import dagger.Component
import javax.inject.Singleton


@Component(modules = [
    HomeModule::class,
    InviteModule::class,
    RegisterModule::class,
    NetworkModule::class,
    ProfileModule::class,
    LoginModule::class,
    ProjectModule::class,
    SessionModule::class,
    ProjectCreateModule::class,
    ProjectEditModule::class,
    SearchModule::class,
    UserModule::class,
    EventModule::class
])
@Singleton
interface AppComponent {
    fun inject(fragment: ProfileFragment)
    fun inject(fragment: ProfileEditFragment)
    fun inject(fragment: LoginFragment)
    fun inject(fragment: ProjectsFragment)
    fun inject(fragment: ProjectDetailFragment)
    fun inject(fragment: ProjectCreateFragment)
    fun inject(fragment: ProjectEditFragment)
    fun inject(fragment: RegisterFragment)
    fun inject(fragment: SearchFragment)
    fun inject(fragment: UserListFragment)
    fun inject(fragment: InviteFragment)
    fun inject(fragment: EventFragment)
    fun inject(fragment: MilestoneFragment)
    fun inject(fragment: RecentProjectsFragment)
    fun inject(fragment: UserFragment)
    fun inject(fragment: FollowListFragment)
    fun inject(fragment: EventDetailFragment)
}