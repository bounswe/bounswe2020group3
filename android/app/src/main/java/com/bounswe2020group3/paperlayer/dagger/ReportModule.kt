package com.bounswe2020group3.paperlayer.dagger

import com.bounswe2020group3.paperlayer.profile.report.ReportContract
import com.bounswe2020group3.paperlayer.profile.report.ReportPresenter
import dagger.Binds
import dagger.Module

@Module
abstract class ReportModule {

    @Binds
    abstract fun bindReportPresenter(presenter: ReportPresenter): ReportContract.Presenter
}