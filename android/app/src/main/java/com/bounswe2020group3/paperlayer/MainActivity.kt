package com.bounswe2020group3.paperlayer

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.navigation.NavController
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.bounswe2020group3.paperlayer.dagger.AppComponent
import com.bounswe2020group3.paperlayer.dagger.DaggerAppComponent
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(){

    lateinit var navController: NavController
    private lateinit var appComponent: AppComponent

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        appComponent = DaggerAppComponent.create()

        setContentView(R.layout.activity_main)

        navController = findNavController(R.id.fragment)
        val appBarConfiguration = AppBarConfiguration(setOf(
            R.id.eventFragment, R.id.projectMainFragment, R.id.profileFragment,R.id.searchFragment
        ))
        setupActionBarWithNavController(navController, appBarConfiguration)

        navigationBarBottom.setupWithNavController(navController)
    }

    override fun onSupportNavigateUp(): Boolean {
        navController.navigateUp()

        return super.onSupportNavigateUp()
    }

    fun getAppComponent() = appComponent

    fun hideBottomNav() {
        navigationBarBottom.visibility = View.GONE
    }

    fun showBottomNav() {
        navigationBarBottom.visibility = View.VISIBLE
    }
}