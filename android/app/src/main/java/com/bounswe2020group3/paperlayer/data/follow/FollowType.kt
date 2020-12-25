package com.bounswe2020group3.paperlayer.data.follow

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
enum class FollowType(val value: String) : Parcelable {
    FOLLOWER("follower"),
    FOLLOWING("following")
}