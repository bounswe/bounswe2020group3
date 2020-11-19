package com.bounswe2020group3.paperlayer.profile

import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.network.RetrofitProvider
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class ProfileModel: ProfileContract.Model {

    private var profileService: ProfileContract.ProfileService = RetrofitProvider.instance.create(ProfileContract.ProfileService::class.java)

    override fun getProfile(profileId: Int): Single<Profile> {
        return profileService.getProfile(profileId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
    }

}