package com.bounswe2020group3.paperlayer.profile


import android.util.Log
import com.bounswe2020group3.paperlayer.login.data.AuthToken
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.util.Session
import com.bounswe2020group3.paperlayer.util.SessionManager
import com.bounswe2020group3.paperlayer.util.TOKEN
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import java.lang.Exception
import javax.inject.Inject

class ProfileModel @Inject constructor(private var sessionManager: Session): ProfileContract.Model {

    private var profileService: ProfileContract.Service = RetrofitProvider.instance.create(ProfileContract.Service::class.java)
    private var userProfile: BehaviorSubject<Profile> = BehaviorSubject.create()

    private fun getAuthToken(): AuthToken {
        return sessionManager.getToken().value ?: throw Exception("No user found")
    }

    override fun getUserProfile(): BehaviorSubject<Profile> {
        return userProfile
    }

    override fun updateUserProfile(updatedProfile: Profile): Single<Profile> {
        val authorization = TOKEN
        return profileService.updateProfile(authorization, 3, updatedProfile)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doAfterSuccess() { profile ->
                    userProfile.onNext(profile)
                }
    }

    override fun fetchUserProfile(): Single<Profile> {
        Log.d("Test", "$sessionManager")
        Log.d("Test", "${sessionManager.getToken().value}")
        val userId = getAuthToken().id
        return profileService.getProfile(3)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doAfterSuccess() { profile -> userProfile.onNext(profile)}
    }

}