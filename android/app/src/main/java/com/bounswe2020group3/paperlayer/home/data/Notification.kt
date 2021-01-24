package com.bounswe2020group3.paperlayer.home.data

import com.bounswe2020group3.paperlayer.project.data.Tag
import com.squareup.moshi.Json
import java.text.SimpleDateFormat
import java.util.*

data class Notification(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "actor") var actor: NotificationActor,
        @field:Json(name = "description") var description: String,
        @field:Json(name = "recipient") var recipient: NotificationActor,
        @field:Json(name = "unread") var unread: Boolean,
        @field:Json(name = "verb") var verb: String,
        @field:Json(name = "timestamp") var timestamp: String,
        @field:Json(name = "project") var project: NotificationProject?,
        @field:Json(name = "comment") var comment: NotificationComment?,
        @field:Json(name = "rating") var rating: NotificationRating?,
        @field:Json(name = "following") var following: NotificationFollowing?,
        @field:Json(name = "milestone") var milestone: NotificationMilestone?,
        @field:Json(name = "follow_request") var follow_request: NotificationFollowRequest?,
        @field:Json(name = "request") var collaboration_request: NotificationCollaborationRequest?,
        @field:Json(name = "invite") var project_invite: NotificationInvite?,
) {
    val date: String get() =
            SimpleDateFormat("dd.MM.yyyy HH:mm", Locale.ENGLISH).format(SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'", Locale.ENGLISH).parse(timestamp))

    val notificationType: NotificationType get() = NotificationType.fromString(description)
}

data class NotificationProject(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "name") var name: String,
        @field:Json(name = "description") var description: String,
        @field:Json(name = "owner") var owner: String,
        @field:Json(name = "project_type") var project_type: String,
        @field:Json(name = "tags") var tags: List<Tag>,
        @field:Json(name = "is_public") var is_public: Boolean,
        @field:Json(name = "state") var state: String,
        @field:Json(name = "owner_id") var owner_id: Int
)

data class NotificationComment(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "comment") var comment: String
)

data class NotificationRating(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "created") var created: String,
        @field:Json(name = "rating") var rating: Int,
        @field:Json(name = "from_user") var from_user: Int,
        @field:Json(name = "to_user") var to_user: Int
)

data class NotificationFollowing(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "to_user") var to_user: Int,
        @field:Json(name = "created") var created: String,
)

data class NotificationMilestone(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "description") var description: String,
        @field:Json(name = "date") var date: String,
        @field:Json(name = "project") var project: Int
)

data class NotificationFollowRequest(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "req_from_user") var req_from_user: NotificationUser,
        @field:Json(name = "req_to_user") var req_to_user: NotificationUser,
        @field:Json(name = "created") var created: String,
)

data class NotificationUser(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "username") var username: String,
)

data class NotificationCollaborationRequest(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "to_user") var to_user: Int,
        @field:Json(name = "from_user") var from_user: Int,
        @field:Json(name = "message") var message: String,
        @field:Json(name = "created") var created: String,
        @field:Json(name = "rejected") var rejected: String?,
        @field:Json(name = "to_project") var to_project: Int)

data class NotificationInvite(
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "to_user") var to_user: Int,
        @field:Json(name = "from_user") var from_user: Int,
        @field:Json(name = "message") var message: String,
        @field:Json(name = "created") var created: String,
        @field:Json(name = "rejected") var rejected: String?,
        @field:Json(name = "to_project") var to_project: Int)
