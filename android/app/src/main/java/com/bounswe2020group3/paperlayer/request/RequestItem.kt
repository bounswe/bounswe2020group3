package com.bounswe2020group3.paperlayer.request

data class RequestItem(
    var id: Int,
    var userId: Int,
    var fullName: String,
    var photoUrl: String,
    var message: String?,
    var projectId: Int?,
)