package com.bounswe2020group3.paperlayer.data.user

import com.squareup.moshi.Json


data class Report(
    @field:Json(name = "report_type")
    var reportType: String,
    @field:Json(name = "description")
    var description: String?,
    @field:Json(name = "reported_user")
    var reportedUser: Int
) {}
