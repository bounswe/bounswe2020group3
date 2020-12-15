package com.bounswe2020group3.paperlayer.invite.data

import com.squareup.moshi.Json

data class InviteRequest(
        @field:Json(name = "to_user") var to_user: Int,
        @field:Json(name = "to_project") var to_project: Int,
        @field:Json(name = "message") var message: String,
)