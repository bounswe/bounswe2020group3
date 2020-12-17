package com.bounswe2020group3.paperlayer.project.data
import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Milestone (
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "description")
        var description: String,
        @field:Json(name = "date")
        var date: String,
        @field:Json(name = "project")
        var project: Int
) : Parcelable