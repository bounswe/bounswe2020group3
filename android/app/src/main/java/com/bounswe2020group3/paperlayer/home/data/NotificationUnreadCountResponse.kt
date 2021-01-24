package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

data class NotificationUnreadCountResponse(
        @field:Json(name = "unread_count") var unread_count: Int
)