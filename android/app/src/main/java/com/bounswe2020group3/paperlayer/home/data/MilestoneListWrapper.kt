package com.bounswe2020group3.paperlayer.home.data

import com.squareup.moshi.Json

data class MilestoneListWrapper(
        @field:Json(name = "result")
        var result : List<Milestone>

)
