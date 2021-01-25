package com.bounswe2020group3.paperlayer.feed.data

import java.util.*

enum class FeedType(val key: Int, val value: String) {
    EVENT(0, "Event"),
    PROJECT(1, "Project"),
    FOLLOW(2, "Follow"),
    RATING(3, "Rating"),
    COMMENT(4, "Comment");

    companion object {
        fun fromString(value: String): FeedType {
            return when (value.toLowerCase(Locale.ROOT)) {
                EVENT.value.toLowerCase(Locale.ROOT) -> EVENT
                PROJECT.value.toLowerCase(Locale.ROOT) -> PROJECT
                FOLLOW.value.toLowerCase(Locale.ROOT) -> FOLLOW
                RATING.value.toLowerCase(Locale.ROOT) -> RATING
                COMMENT.value.toLowerCase(Locale.ROOT) -> COMMENT
                else -> COMMENT
            }
        }
    }

}