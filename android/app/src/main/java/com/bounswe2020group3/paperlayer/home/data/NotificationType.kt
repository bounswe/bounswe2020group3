package com.bounswe2020group3.paperlayer.home.data

import java.util.*

enum class NotificationType(val key: Int,val value: String) {

    COMMENT(0, "Comment"),
    PROJECT(1, "Project"),
    RATING(2, "Rating"),
    FOLLOW(3, "Follow"),
    MILESTONE(4, "Milestone"),
    FOLLOW_REQUEST(5, "Follow Request"),
    REQUEST(6, "Request"),
    INVITE(7, "Invite");


    companion object {
        fun fromString(value: String): NotificationType {
            return when (value.toLowerCase(Locale.ROOT)) {
                COMMENT.value.toLowerCase(Locale.ROOT) -> COMMENT
                PROJECT.value.toLowerCase(Locale.ROOT) -> PROJECT
                RATING.value.toLowerCase(Locale.ROOT) -> RATING
                FOLLOW.value.toLowerCase(Locale.ROOT) -> FOLLOW
                MILESTONE.value.toLowerCase(Locale.ROOT) -> MILESTONE
                FOLLOW_REQUEST.value.toLowerCase(Locale.ROOT) -> FOLLOW_REQUEST
                REQUEST.value.toLowerCase(Locale.ROOT) -> REQUEST
                INVITE.value.toLowerCase(Locale.ROOT) -> INVITE
                else -> COMMENT
            }
        }
    }


}