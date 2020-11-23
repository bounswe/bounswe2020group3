package com.bounswe2020group3.paperlayer.profile

import android.util.Log
import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.profile.data.User
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import java.lang.Exception
import javax.inject.Inject

class ProfileModel @Inject constructor(private var sessionManager: Session) : ProfileContract.Model {

    private var profileService: ProfileContract.Service = RetrofitProvider.instance.create(ProfileContract.Service::class.java)
    private var userProfile: BehaviorSubject<Profile> = BehaviorSubject.create()

    private var user: BehaviorSubject<User> = BehaviorSubject.create()

    private fun getAuthToken(): AuthToken {
        return sessionManager.getToken().value ?: throw Exception("No user found")
    }

    override fun getUser(): BehaviorSubject<User> {
        return user
    }

    override fun updateUserProfile(updatedProfile: Profile): Single<Profile> {
        val userId = getAuthToken().id
        val authorization = "Token ${getAuthToken().token}"
        Log.d("Test", "User id: $userId")
        Log.d("Test", "Authorization: ${authorization}")
        Log.d("Test", "Profile id ${updatedProfile.id}")
        return profileService.updateProfile(authorization, updatedProfile.id!!, updatedProfile)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doAfterSuccess() { profile ->
                    userProfile.onNext(profile)
                }
    }

    override fun fetchUser(): Single<User> {
        Log.d("Test", "$sessionManager")
        Log.d("Test", "${sessionManager.getToken().value}")
        val userId = getAuthToken().id
        Log.d("Test", "${userId}")
        return profileService.getUser(userId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doAfterSuccess() { u -> user.onNext(u) }
    }
}