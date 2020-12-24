package com.bounswe2020group3.paperlayer.data.follow

import com.bounswe2020group3.paperlayer.data.user.User
import com.squareup.moshi.Json

data class FollowRequest(
        @field:Json(name = "req_from_user")
        var requestFromUser: User,
        @field:Json(name = "req_to_user")
        var requestToUser: User,
        @field:Json(name = "created")
        var created: String,
) : ListableFollow {

    override fun fetchFromUser(): User {
        return requestFromUser
    }

    override fun fetchToUser(): User {
        return requestToUser
    }

    override fun fetchCreated(): String {
        return created
    }
}