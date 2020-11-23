package com.bounswe2020group3.paperlayer.mvp

import androidx.annotation.CallSuper

abstract class BasePresenter<V: Mvp.View>  : Mvp.Presenter<V> {

    protected var view: V? = null

    @CallSuper
    override fun bind(view: V) {
        this.view = view
    }

    @CallSuper
    override fun unbind() {
        this.view = null
    }
}