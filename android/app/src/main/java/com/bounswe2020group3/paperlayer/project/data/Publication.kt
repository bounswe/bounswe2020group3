package com.bounswe2020group3.paperlayer.project.data

import android.os.Parcelable
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

//data class for project model in paperlayer API
@Parcelize
data class Publication (
        @field:Json(name = "id") var id: Int,
        @field:Json(name = "title") var title: String,
        @field:Json(name = "publication_year") var publicationYear: Int,
        @field:Json(name = "abstract") var abstract: String,
        @field:Json(name = "authors") var authors: String,
        @field:Json(name = "journal") var journal: String,
        @field:Json(name = "citation_number") var citationNumber: Int,
        @field:Json(name = "owner") var ownerId: Int
) : Parcelable