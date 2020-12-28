package com.bounswe2020group3.paperlayer.collaborationRequests

data class CollabCard (
        var id: Int,
        var userid: Int,
        var username: String,
        var fullName: String,
        var date: String,
        var message: String,
        var photourl: String,
        var expertise : String
        ){
}
