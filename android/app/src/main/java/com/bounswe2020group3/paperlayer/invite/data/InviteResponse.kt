package com.bounswe2020group3.paperlayer.invite.data

import com.squareup.moshi.Json

data class InviteResponse(
        @field:Json(name = "to_user") var to_user: String,
        @field:Json(name = "to_project") var to_project: String,
        @field:Json(name = "message") var message: String,
)