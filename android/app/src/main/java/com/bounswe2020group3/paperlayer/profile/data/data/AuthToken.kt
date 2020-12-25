package com.bounswe2020group3.paperlayer.profile.data.data

import com.squareup.moshi.Json

class AuthToken (
        @field:Json(name = "token")
        var token: String,
        @field:Json(name = "id")
        var id: Int
)