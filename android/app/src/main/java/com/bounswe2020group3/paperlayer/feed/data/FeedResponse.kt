package com.bounswe2020group3.paperlayer.feed.data

import com.squareup.moshi.Json

data class FeedResponse(
    @field:Json(name = "count") var count: Int,
    @field:Json(name = "results") var feedList: List<Feed>?,
)