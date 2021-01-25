package com.bounswe2020group3.paperlayer.feed.data

import com.bounswe2020group3.paperlayer.home.data.NotificationType
import com.squareup.moshi.Json

data class Feed(
    @field:Json(name = "actor") var actor: String,
    @field:Json(name = "type") var type: String,
    @field:Json(name = "verb") var verb: String,
    @field:Json(name = "time") var time: String,
    @field:Json(name = "project") var project: FeedProject?,
    @field:Json(name = "follow") var follow: FeedFollow?,
    @field:Json(name = "event") var event: FeedEvent?,
    @field:Json(name = "rating") var rating: FeedRating?,
    @field:Json(name = "comment") var comment: FeedComment?,
) {
    val feedType: FeedType get() = FeedType.fromString(type)
}

data class FeedProject(
    @field:Json(name = "id") var id: Int,
    @field:Json(name = "name") var name: String,
    @field:Json(name = "description") var description: String,
    @field:Json(name = "owner") var owner: String,
    @field:Json(name = "project_type") var project_type: String,
    @field:Json(name = "is_public") var is_public: Boolean,
    @field:Json(name = "state") var state: String,
    @field:Json(name = "owner_id") var owner_id: Int
)

data class FeedFollow(
    @field:Json(name = "id") var id: Int,
    @field:Json(name = "from_user") var from_user: FeedUser,
    @field:Json(name = "to_user") var to_user: FeedUser,
    @field:Json(name = "created") var created: String,
)

data class FeedEvent(
    @field:Json(name = "id") var id: Int,
    @field:Json(name = "description") var description: String,
)

data class FeedRating(
    @field:Json(name = "id") var id: Int,
    @field:Json(name = "from_user") var from_user: FeedUser,
    @field:Json(name = "to_user") var to_user: FeedUser,
    @field:Json(name = "rating") var rating: Int,
)

data class FeedComment(
    @field:Json(name = "id") var id: Int,
    @field:Json(name = "from_user") var from_user: FeedUser,
    @field:Json(name = "to_user") var to_user: FeedUser,
    @field:Json(name = "comment") var comment: String,

)

data class FeedUser(
    @field:Json(name = "id") var id: Int,
    @field:Json(name = "username") var username: String,
)
