package com.bounswe2020group3.paperlayer.project.data

import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Profile (
        @field:Json(name = "id")
        var id: Int,
        @field:Json(name = "name")
        var name: String?,
        @field:Json(name = "middle_name")
        var middleName: String?,
        @field:Json(name = "last_name")
        var lastName: String?,
        @field:Json(name = "owner")
        var owner: String?,
        @field:Json(name = "email")
        var email: String?,
        @field:Json(name = "bio")
        var bio: String?,
        @field:Json(name = "profile_picture")
        var profilePicture: String?,
        @field:Json(name = "birthday")
        var birthday: String?,
        @field:Json(name = "share_birthday")
        var shareBirthday: Boolean?,
        @field:Json(name = "expertise")
        var expertise: String?,
        @field:Json(name = "gender")
        var gender: String?,
        @field:Json(name = "interests")
        var interests: String?,
        @field:Json(name = "affiliations")
        var affiliations: String?,
        @field:Json(name = "share_bio")
        var shareBio: Boolean?,
        @field:Json(name = "share_gender")
        var shareGender: Boolean?,
        @field:Json(name = "share_affiliations")
        var shareAffiliations: Boolean?,
        @field:Json(name = "age")
        var age: Int?,
        @field:Json(name = "share_age")
        var shareAge: Boolean?,
        @field:Json(name = "is_public")
        var isPublic: Boolean?,
        @field:Json(name = "rating")
        var rating: String?,
        @field:Json(name = "my_rating")
        var myRating: String?,
        @field:Json(name = "my_rating_id")
        var myRatingId: String?,
        @field:Json(name = "is_commentable")
        var isCommentable: Boolean?,
        @field:Json(name = "owner_id")
        var ownerId: Int
) : Parcelable