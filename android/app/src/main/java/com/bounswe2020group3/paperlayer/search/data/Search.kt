package com.bounswe2020group3.paperlayer.search.data

import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Search(
        @field:Json(name = "keyword")
        var keyword: String,
        @field:Json(name = "search_type")
        var searchType: String?,
        @field:Json(name = "profile_affiliations")
        var profileAffiliations: String?,
        @field:Json(name = "profile_expertise")
        var profileExpertise: String?,
        @field:Json(name = "event_date_after")
        var eventDateAfter: String?,
        @field:Json(name = "event_date_before")
        var eventDateBefore: String?,
        @field:Json(name = "event_deadline_after")
        var eventDeadlineAfter: String?,
        @field:Json(name = "event_deadline_before")
        var eventDeadlineBefore: String?,
        @field:Json(name = "event_type")
        var eventType: String?,
        @field:Json(name = "project_due_date_after")
        var projectDueDateAfter: String?,
        @field:Json(name = "project_due_date_before")
        var projectDueDateBefore: String?,
        @field:Json(name = "project_event")
        var projectEvent: Int?,
        @field:Json(name="project_state")
        var projectState: String?
):Parcelable