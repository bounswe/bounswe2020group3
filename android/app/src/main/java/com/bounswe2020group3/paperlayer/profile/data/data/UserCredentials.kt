package com.bounswe2020group3.paperlayer.profile.data.data

import com.squareup.moshi.Json
data class UserCredentials (
        @field:Json(name = "username")
        var username: String,
        @field:Json(name = "password")
        var password: String
)