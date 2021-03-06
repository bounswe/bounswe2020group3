package com.bounswe2020group3.paperlayer.search.data

import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class User(
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "username")
        var username: String,
        @field:Json(name="profile")
        var profile: List<ProfileShort>
):Parcelable