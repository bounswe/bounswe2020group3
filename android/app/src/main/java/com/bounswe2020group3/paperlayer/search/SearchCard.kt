package com.bounswe2020group3.paperlayer.search

import com.bounswe2020group3.paperlayer.project.data.Tag

data class SearchCard(
        var searchType: Int, //0:Project,1:User,2:Event
        var titleIconType: Int, //Project
        var title: String,
        var body: String,
        var supportText: String,
        var tags: List<Tag>,
        var id: Int //Unique ID of project,user,event
) {


}