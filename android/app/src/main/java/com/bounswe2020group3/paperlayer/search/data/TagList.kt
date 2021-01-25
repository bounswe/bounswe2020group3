package com.bounswe2020group3.paperlayer.search.data

import android.os.Parcelable
import com.bounswe2020group3.paperlayer.project.data.Tag
import com.squareup.moshi.Json
import kotlinx.android.parcel.Parcelize

@Parcelize
data class TagList(
        @field:Json(name = "tags")
        var tags: List<Tag>?
):Parcelable