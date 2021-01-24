package com.bounswe2020group3.paperlayer.project.data

import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class File (
    @field:Json(name = "id")
    var id: Int,
    @field:Json(name = "file")
    var url: String,
    @field:Json(name = "remark")
    var name: String,
    @field:Json(name = "timestamp")
    var timestamp: Int,
    @field:Json(name = "project")
    var project: Int
) : Parcelable