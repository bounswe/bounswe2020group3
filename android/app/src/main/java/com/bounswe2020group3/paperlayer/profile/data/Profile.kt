package com.bounswe2020group3.paperlayer.profile.data

import com.squareup.moshi.Json

data class Profile (
    @field:Json(name = "name")
    var name: String,
    @field:Json(name = "middle_name")
    var middleName: String,
    @field:Json(name = "last_name")
    var lastName: String,
    @field:Json(name = "bio")
    var bio: String,
    @field:Json(name = "photo_url")
    var photoUrl: String,
    @field:Json(name = "age")
    var age: Int,
    @field:Json(name = "share_age")
    var shareAge: Boolean,
    @field:Json(name = "expertise")
    var expertise: String,
    @field:Json(name = "gender")
    var gender: String,
    @field:Json(name = "interests")
    var interests: String
)