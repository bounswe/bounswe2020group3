package com.bounswe2020group3.paperlayer.register.data


import com.squareup.moshi.Json

data class Register (
        @field:Json(name = "first_name")
        var first_name: String,
        @field:Json(name = "middle_name")
        var middleName: String,
        @field:Json(name = "last_name")
        var lastName: String,
        @field:Json(name = "username")
        var username: String,
        @field:Json(name = "email")
        var email: String,
        @field:Json(name = "password")
        var password: String,

        )