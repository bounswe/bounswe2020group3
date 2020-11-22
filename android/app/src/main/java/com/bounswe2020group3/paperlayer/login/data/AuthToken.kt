package com.bounswe2020group3.paperlayer.login.data

import com.squareup.moshi.Json

class AuthToken (
        @field:Json(name = "username")
        var username: String,
        @field:Json(name = "password")
        var password: String,
        @field:Json(name = "token")
        var token: String
)