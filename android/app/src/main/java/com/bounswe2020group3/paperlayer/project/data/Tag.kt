package com.bounswe2020group3.paperlayer.project.data

import com.squareup.moshi.Json

data class Tag (
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "name")
        var name: String
)