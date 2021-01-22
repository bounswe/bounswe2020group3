package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

data class Notification(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "actor") var actor: NotificationActor,
        @field:Json(name = "description") var description: String,
        @field:Json(name = "recipient") var recipient: NotificationActor,
        @field:Json(name = "unread") var unread: Boolean,
        @field:Json(name = "verb") var verb: String,
        @field:Json(name = "timestamp") var timestamp: String,
) {


}