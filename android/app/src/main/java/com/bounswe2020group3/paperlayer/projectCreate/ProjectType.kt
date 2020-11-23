package com.bounswe2020group3.paperlayer.projectCreate

enum class ProjectType(val key: Int, val value: String) {
    CONFERENCE(0, "Conference"),
    INSTITUTION(1, "Instutution"), // Tell backend to fix typo
    JOURNAL(3, "Journal")
}