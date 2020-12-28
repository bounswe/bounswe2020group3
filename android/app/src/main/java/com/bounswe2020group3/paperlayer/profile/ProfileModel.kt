package com.bounswe2020group3.paperlayer.profile

import android.net.Uri
import android.os.FileUtils
import com.bounswe2020group3.paperlayer.data.user.AuthToken
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import com.bounswe2020group3.paperlayer.data.user.Profile
import com.bounswe2020group3.paperlayer.data.user.User
import com.bounswe2020group3.paperlayer.util.Session
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.reactivex.subjects.BehaviorSubject
import okhttp3.MediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody
import retrofit2.Response
import java.io.File
import java.io.InputStream
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
        val authorization = "Token ${getAuthToken().token}"
        return profileService.getUser(authorization, userId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doAfterSuccess() { u -> authUser.onNext(u) }
    }

    override fun getUser(userId: Int): Single<User> {
        val authorization = "Token ${getAuthToken().token}"
        return profileService.getUser(authorization, userId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

    override fun getUserList(): Observable<List<User>> {
        return profileService.getUserList()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .flatMap { userList -> Observable.fromArray(userList.subList(1, userList.size - 1)) }
    }

    override fun updateProfilePicture(profileId: Int, file: File, type: MediaType): Observable<Response<Void>> {
        val authorization = "Token ${getAuthToken().token}"
        val fileRequestBody: RequestBody = RequestBody.create(type, file)
        val pictureFile: MultipartBody.Part = MultipartBody.Part.createFormData("profile_picture", file.name, fileRequestBody)
        return profileService.updateProfilePicture(authorization, profileId, pictureFile)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }
}