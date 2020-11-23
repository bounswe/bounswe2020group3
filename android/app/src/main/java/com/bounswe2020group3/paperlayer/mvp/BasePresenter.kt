package com.bounswe2020group3.paperlayer.mvp

abstract class BasePresenter<V: Mvp.View>  : Mvp.Presenter<V> {

    protected var view: V? = null

    override fun bind(view: V) {
        this.view = view
    }

    override fun unbind() {
        this.view = null
    }
}