package com.bounswe2020group3.paperlayer.invite;

data class InviteCard(
        var userId: Int,
        var username : String,
        var name: String,
        var expertise: String?,
        var photo_url: String?,
        var id : Int,
        var called : Boolean
) {


}