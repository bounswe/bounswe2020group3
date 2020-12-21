package com.bounswe2020group3.paperlayer.profile.data

import com.squareup.moshi.Json

data class User (
        @field:Json(name = "id")
    var id: Int,
        @field:Json(name = "username")
    var username: String,
        @field:Json(name = "email")
    var email: String,
        @field:Json(name = "profile")
    var profile: List<Profile>,
)