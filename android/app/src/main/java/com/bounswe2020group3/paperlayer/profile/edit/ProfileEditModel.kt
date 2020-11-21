package com.bounswe2020group3.paperlayer.profile.edit

import com.bounswe2020group3.paperlayer.profile.common.ProfileCommonModel
import com.bounswe2020group3.paperlayer.profile.data.Profile
import io.reactivex.Single

class ProfileEditModel: ProfileCommonModel(), ProfileEditContract.Model {
    override fun updateProfile(profileId: Int, updatedProfile: Profile): Single<Profile> {
        TODO("Not yet implemented")
    }
}