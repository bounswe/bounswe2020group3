package com.bounswe2020group3.paperlayer.data.user

import com.squareup.moshi.Json

data class User (
    @field:Json(name = "id")
    var id: Int,
    @field:Json(name = "username")
    var username: String,
    @field:Json(name = "email")
    var email: String?,
    @field:Json(name = "profile")
    var profile: List<Profile>,
    @field:Json(name = "is_follower")
    var isFollower: Boolean,
    @field:Json(name = "is_following")
    var isFollowing: Boolean,
    @field:Json(name = "is_follow_request_sent")
    var isFollowRequestSent: Boolean,
    @field:Json(name = "is_follow_request_received")
    var isFollowRequestReceived: Boolean,
    @field:Json(name = "count_of_followers")
    var countOfFollowers: Int,
    @field:Json(name = "count_of_followings")
    var countOfFollowings: Int,
    @field:Json(name = "count_of_follow_requests")
    var countOfFollowRequests: Int
)