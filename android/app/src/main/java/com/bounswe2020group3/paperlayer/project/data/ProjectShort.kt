package com.bounswe2020group3.paperlayer.project.data

import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class ProjectShort (
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "name")
        var name: String,
        @field:Json(name = "description")
        var description: String,
        @field:Json(name = "owner")
        var owner: String,
        @field:Json(name = "is_public")
        var isPublic: Boolean,
        @field:Json(name = "state")
        var state: String
): Parcelable
