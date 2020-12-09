package com.bounswe2020group3.paperlayer.project.data

import com.squareup.moshi.Json

data class Event (
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "title")
        var title: String,
        @field:Json(name = "description")
        var description: String,
        @field:Json(name = "deadline")
        var deadline: String,
        @field:Json(name = "date")
        var date: String,
        @field:Json(name = "event_type")
        var eventType: String,
        @field:Json(name = "url")
        var url: String
)