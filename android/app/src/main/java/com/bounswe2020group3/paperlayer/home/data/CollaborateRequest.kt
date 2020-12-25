package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

data class CollaborateRequest (
        @field:Json(name = "to_project")
        var to_project: Int,
        @field:Json(name = "message")
        var message: String,
        )
{}