package com.bounswe2020group3.paperlayer.search.data

import android.os.Parcelable
import com.bounswe2020group3.paperlayer.project.data.Event
import com.bounswe2020group3.paperlayer.project.data.Profile
import com.bounswe2020group3.paperlayer.project.data.Project
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class SearchResponse(
        @field:Json(name = "events")
        var events: List<Event>?,
        @field:Json(name = "projects")
        var projects: List<Project>?,
        @field:Json(name = "profiles")
        var profiles: List<Profile>?

): Parcelable