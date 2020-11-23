package com.bounswe2020group3.paperlayer.projectCreate

enum class ProjectState(val key: Int,val value: String) {
    SEEKING(0, "Seeking for collaborators"),
    OPEN(1, "Open for collaborators"),
    IN_PROGRESS(2, "In progress"),
    DONE(3, "Done")
}