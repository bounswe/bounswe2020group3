package com.bounswe2020group3.paperlayer.project.data
import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class User (
    @field:Json(name = "id")
    var id: Int,
    @field:Json(name = "username")
    var username: String,
    @field:Json(name = "profile")
    var profile: List<Profile>,
    @field:Json(name = "is_follower")
    var is_follower: Boolean,
    @field:Json(name = "is_following")
    var is_following: Boolean,
    @field:Json(name = "is_follow_request_sent")
    var is_follow_request_sent: Boolean,
    @field:Json(name = "is_follow_request_received")
    var is_follow_request_received: Boolean,
    @field:Json(name = "count_of_followers")
    var count_of_followers: Int,
    @field:Json(name = "count_of_followings")
    var count_of_followings: Int,
    @field:Json(name = "count_of_follow_requests")
    var count_of_follow_requests: Int

) : Parcelable