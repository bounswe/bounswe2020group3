package com.bounswe2020group3.paperlayer.data.follow

import com.squareup.moshi.Json

data class FollowRequestCreate(
    @field:Json(name = "req_from_user")
    var requestFromUser: Int,
    @field:Json(name = "req_to_user")
    var requestToUser: Int,
) {}