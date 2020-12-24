package com.bounswe2020group3.paperlayer

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.View
import androidx.navigation.NavController
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.bounswe2020group3.paperlayer.dagger.AppComponent
import com.bounswe2020group3.paperlayer.dagger.DaggerAppComponent
import com.bounswe2020group3.paperlayer.profile.follow.FollowType
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    lateinit var navController: NavController
    private lateinit var appComponent: AppComponent

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        appComponent = DaggerAppComponent.create()

        setContentView(R.layout.activity_main)

        navController = findNavController(R.id.fragment)

        navController.addOnDestinationChangedListener { controller, destination, arguments ->
            if (destination.id == R.id.followListFragment && arguments != null) {
                when ((arguments.get("followType") as FollowType)) {
                    FollowType.FOLLOWER -> {
                        destination.label = "Followers"
                    }
                    FollowType.FOLLOWING -> {
                        destination.label = "Followings"
                    }
                    else -> {
                        destination.label = "Follow Requests"
                    }
                }
            }

            // Hide toolbar on main fragment
            if (controller.currentDestination?.id == R.id.mainFragment) {
                toolbar.visibility = View.INVISIBLE
            } else {
                toolbar.visibility = View.VISIBLE
            }

            // Hide notification button on login and register fragments
            if (controller.currentDestination?.id in setOf(R.id.loginFragment, R.id.registerFragment)) {
                findViewById<View>(R.id.itemNotificationAction)?.visibility = View.GONE
            } else {
                findViewById<View>(R.id.itemNotificationAction)?.visibility = View.VISIBLE
            }
        }

        // Set toolbar invisible by default
        toolbar.visibility = View.INVISIBLE

        // Use custom toolbar
        setSupportActionBar(toolbar)

        val bottomNavConfiguration = AppBarConfiguration(setOf(
                R.id.eventFragment, R.id.projectMainFragment, R.id.profileFragment, R.id.searchFragment
        ))

        setupActionBarWithNavController(navController, bottomNavConfiguration)
        navigationBarBottom.setupWithNavController(navController)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.top_options_menu, menu)
        return true
    }

    override fun onSupportNavigateUp(): Boolean {
        return navController.navigateUp() || super.onSupportNavigateUp()
    }

    fun getAppComponent() = appComponent

    fun hideBottomNav() {
        navigationBarBottom.visibility = View.GONE
    }

    fun showBottomNav() {
        navigationBarBottom.visibility = View.VISIBLE
    }
}