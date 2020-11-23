package com.bounswe2020group3.paperlayer.projectCreate

import com.squareup.moshi.Json

data class ProjectCreateResponse(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "name") var name: String,
        @field:Json(name = "description") var description: String,
        @field:Json(name = "requirements") var requirements: String,
        @field:Json(name = "owner") var owner: String,
        @field:Json(name = "members") var members: List<String>,
        @field:Json(name = "is_public") var is_public: Boolean,
        @field:Json(name = "state") var state: String,
        @field:Json(name = "project_type") var project_type: String,
        @field:Json(name = "due_date") var due_date: String,
        @field:Json(name = "events") var events: List<String>,
)