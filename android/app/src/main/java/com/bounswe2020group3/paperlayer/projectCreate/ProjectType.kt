package com.bounswe2020group3.paperlayer.projectCreate

import java.util.*
import kotlin.collections.ArrayList

enum class ProjectType(val key: Int, val value: String) {
    CONFERENCE(0, "Conference"),
    INSTITUTION(1, "Instutution"), // Tell backend to fix typo
    JOURNAL(3, "Journal");

    companion object {

        fun fromString(value: String): ProjectType? {
            return when (value) {
                CONFERENCE.value.toLowerCase(Locale.ROOT) -> CONFERENCE
                INSTITUTION.value.toLowerCase(Locale.ROOT) -> INSTITUTION
                JOURNAL.value.toLowerCase(Locale.ROOT) -> JOURNAL
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