package com.bounswe2020group3.paperlayer.profile.common

import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

open class ProfileCommonModel: ProfileCommonContract.Model {

    private var profileService: ProfileCommonContract.Service = RetrofitProvider.instance.create(ProfileCommonContract.Service::class.java)

    override fun getProfile(profileId: Int): Single<Profile> {
        return profileService.getProfile(profileId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

}