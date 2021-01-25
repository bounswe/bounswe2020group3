package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

data class NotificationResponse(
        @field:Json(name = "count") var count: Int,
        @field:Json(name = "result") var notificationsList: List<Notification>?,
)