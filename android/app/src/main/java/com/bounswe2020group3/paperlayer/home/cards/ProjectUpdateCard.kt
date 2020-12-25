package com.bounswe2020group3.paperlayer.home.cards

data class ProjectUpdateCard(
        var projectTitle: String,
        var projectBody: String,
        var projectCreator: String,
        var projectId: Int,
        var projectType: String,
        var projectState: String,
        var requestSent: Boolean,
) {


}