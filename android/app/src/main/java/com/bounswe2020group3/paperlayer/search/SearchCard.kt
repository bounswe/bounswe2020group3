package com.bounswe2020group3.paperlayer.search

data class SearchCard(
        var searchType: Int, //0:Project,1:User,2:Event
        var titleIconType: Int, //Project
        var title: String,
        var body: String,
        var supportText: String,
        var tags: List<String>,
        var id: Int //Unique ID of project,user,event
) {


}