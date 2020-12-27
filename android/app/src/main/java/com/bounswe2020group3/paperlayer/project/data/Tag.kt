package com.bounswe2020group3.paperlayer.project.data

import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Tag (
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "name")
        var name: String,
        @field:Json(name = "color")
        var color: Int
) : Parcelable