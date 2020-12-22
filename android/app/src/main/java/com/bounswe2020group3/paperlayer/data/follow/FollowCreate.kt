package com.bounswe2020group3.paperlayer.data.follow

import com.squareup.moshi.Json

data class FollowCreate (
    @field:Json(name = "from_user")
    var fromUser: Int,
    @field:Json(name = "to_user")
    var toUser: Int,
) {}