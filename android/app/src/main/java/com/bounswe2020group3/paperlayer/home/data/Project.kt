package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

//temp
data class Project(
        @field: Json(name = "id")
        var id: Int,
        @field:Json(name = "name")
        var name: String,
        @field:Json(name = "description")
        var description: String,
        @field:Json(name = "owner")
        var owner: String,
        @field:Json(name = "is_public")
        var is_public: String)


{
}