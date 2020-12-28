package com.bounswe2020group3.paperlayer.search.data
import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class ProfileShort (
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "name")
        var name: String,
        @field:Json(name = "middle_name")
        var middlename: String,
        @field:Json(name = "last_name")
        var lastname: String,
        @field:Json(name = "owner")
        var owner: String,
        @field:Json(name = "profile_picture")
        var profilePicture: String,
        @field:Json(name = "isPublic")
        var isPublic: Boolean
): Parcelable