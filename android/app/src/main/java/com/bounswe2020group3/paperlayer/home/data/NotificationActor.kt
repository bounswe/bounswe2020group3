package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

data class NotificationActor(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "username") var username: String,
)