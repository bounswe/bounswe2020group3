package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

data class CollaborationRequest(
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "to_user")
        var to_user: String,
        @field:Json(name = "from_user")
        var from_user: String,
        @field:Json(name = "created")
        var created: String,
        @field:Json(name = "rejected")
        var rejected: String,
        @field:Json(name = "to_project")
        var to_project: Int,
        @field:Json(name = "message")
        var message: String,
)

