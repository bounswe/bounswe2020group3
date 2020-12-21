package com.bounswe2020group3.paperlayer.profile

import com.bounswe2020group3.paperlayer.profile.data.data.AuthToken
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.profile.data.User
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import java.lang.Exception
import javax.inject.Inject

class ProfileModel @Inject constructor(private var sessionManager: Session) : ProfileContract.Model {

    private var profileService: ProfileContract.Service = RetrofitProvider.instance.create(ProfileContract.Service::class.java)

    private var authUserProfile: BehaviorSubject<Profile> = BehaviorSubject.create()
    private var authUser: BehaviorSubject<User> = BehaviorSubject.create()

    private fun getAuthToken(): AuthToken {
        return sessionManager.getToken().value ?: throw Exception("No user found")
    }

    override fun getAuthUser(): BehaviorSubject<User> {
        return authUser
    }

    override fun updateAuthUserProfile(updatedProfile: Profile): Single<Profile> {
        val userId = getAuthToken().id
        val authorization = "Token ${getAuthToken().token}"
        return profileService.updateProfile(authorization, updatedProfile.id, updatedProfile)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doAfterSuccess() { profile ->
                    authUserProfile.onNext(profile)
                }
    }

    override fun fetchAuthUser(): Single<User> {
        val userId = getAuthToken().id
        return profileService.getUser(userId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doAfterSuccess() { u -> authUser.onNext(u) }
    }

    override fun getUserList(): Observable<List<User>> {
        return profileService.getUserList()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .flatMap { userList -> Observable.fromArray(userList.subList(1, userList.size - 1)) }
    }
}