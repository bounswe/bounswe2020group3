package com.bounswe2020group3.paperlayer.project

import com.bounswe2020group3.paperlayer.project.data.Tag

data class ProjectCard(
        var projectTitle: String,
        var projectBody: String,
        var projectCreator: String,
        var projectId: Int,
        var tags: List<Tag>,
        var projectType: String
) {


}