package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

data class Milestone(
        @field:Json(name = "id")
         var id: Int,
         @field:Json(name = "description")
         var description: String,
         @field:Json(name = "date")
         var date: String,
         @field:Json(name = "project")
         var project: Int,
         @field:Json(name = "project_name")
         var project_name: String

)
