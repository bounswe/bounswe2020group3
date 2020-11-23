package com.bounswe2020group3.paperlayer.mvp

interface Mvp {
    interface Presenter<V : View> {

        fun bind(view: V)
        fun unbind()
    }

    interface View {
    }
}