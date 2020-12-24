package com.bounswe2020group3.paperlayer.data.user

import com.squareup.moshi.Json

data class Profile (
    @field:Json(name = "id")
    var id: Int,
    @field:Json(name = "name")
    var name: String?,
    @field:Json(name = "middle_name")
    var middleName: String?,
    @field:Json(name = "last_name")
    var lastName: String?,
    @field:Json(name = "owner")
    var owner: String?,
    @field:Json(name = "email")
    var email: String?,
    @field:Json(name = "bio")
    var bio: String?,
    @field:Json(name = "profile_picture")
    var profile_picture: String?,
    @field:Json(name = "birthday")
    var birthday: String?,
    @field:Json(name = "share_birthday")
    var share_birthday: Boolean?,
    @field:Json(name = "expertise")
    var expertise: String?,
    @field:Json(name = "gender")
    var gender: String?,
    @field:Json(name = "interests")
    var interests: String?,
    @field:Json(name = "affiliations")
    var affiliations: String?,
    @field:Json(name = "share_bio")
    var share_bio: Boolean?,
    @field:Json(name = "share_gender")
    var share_gender: Boolean?,
    @field:Json(name = "share_affiliations")
    var share_affiliations: Boolean?,
    @field:Json(name = "is_public")
    var is_public: Boolean?,
)