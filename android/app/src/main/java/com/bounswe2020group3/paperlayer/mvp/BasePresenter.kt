package com.bounswe2020group3.paperlayer.mvp

import androidx.annotation.CallSuper
import io.reactivex.disposables.CompositeDisposable

abstract class BasePresenter<V: Mvp.View>  : Mvp.Presenter<V> {

    protected var view: V? = null
    protected var compositeDisposable: CompositeDisposable? = null

    @CallSuper
    override fun bind(view: V) {
        this.view = view
        this.compositeDisposable = CompositeDisposable()
    }

    @CallSuper
    override fun unbind() {
        this.view = null
        this.compositeDisposable?.clear()
    }
}