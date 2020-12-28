package com.bounswe2020group3.paperlayer.projectCreate

import java.util.*
import kotlin.collections.ArrayList

enum class ProjectState(val key: Int,val value: String) {
    INVITING(0, "Inviting collaborators"),
    OPEN(1, "Open for collaborators"),
    IN_PROGRESS(2, "In progress"),
    DONE(3, "Done"),
    DRAFT(4, "Draft"),
    SUBMITTED(5, "Submitted to event"),
    PUBLISHED(6, "Published"),
    CANCELLED(7, "Cancelled"),
    REOPENED(8, "Reopened");


    companion object  {
        fun fromString(value: String): ProjectState? {
            return when (value) {
                INVITING.value.toLowerCase(Locale.ROOT) -> INVITING
                OPEN.value.toLowerCase(Locale.ROOT) -> OPEN
                IN_PROGRESS.value.toLowerCase(Locale.ROOT) -> IN_PROGRESS
                DONE.value.toLowerCase(Locale.ROOT) -> DONE
                DRAFT.value.toLowerCase(Locale.ROOT) -> DRAFT
                SUBMITTED.value.toLowerCase(Locale.ROOT) -> SUBMITTED
                PUBLISHED.value.toLowerCase(Locale.ROOT) -> PUBLISHED
                CANCELLED.value.toLowerCase(Locale.ROOT) -> CANCELLED
                REOPENED.value.toLowerCase(Locale.ROOT) -> REOPENED
                else -> INVITING
            }
        }

        fun toList(): ArrayList<String> {
            val listOfValues = ArrayList<String>()
            values().iterator().forEach {
                listOfValues.add(it.value)
            }
            return listOfValues
        }
    }
}