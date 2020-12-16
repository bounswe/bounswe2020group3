package com.bounswe2020group3.paperlayer.projectCreate

import java.util.*
import kotlin.collections.ArrayList

enum class ProjectState(val key: Int,val value: String) {
    SEEKING(0, "Seeking for collaborators"),
    OPEN(1, "Open for collaborators"),
    IN_PROGRESS(2, "In progress"),
    DONE(3, "Done");

    companion object  {
        fun fromString(value: String): ProjectState? {
            return when (value) {
                SEEKING.value.toLowerCase(Locale.ROOT) -> SEEKING
                OPEN.value.toLowerCase(Locale.ROOT) -> OPEN
                IN_PROGRESS.value.toLowerCase(Locale.ROOT) -> IN_PROGRESS
                DONE.value.toLowerCase(Locale.ROOT) -> DONE
                else -> null
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