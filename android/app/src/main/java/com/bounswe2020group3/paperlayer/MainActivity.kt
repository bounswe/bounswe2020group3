package com.bounswe2020group3.paperlayer

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.NavController
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.bounswe2020group3.paperlayer.dagger.AppComponent
import com.bounswe2020group3.paperlayer.dagger.DaggerAppComponent
import com.bounswe2020group3.paperlayer.profile.follow.FollowType
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.layout_with_badge.*


class MainActivity : AppCompatActivity() {

    lateinit var navController: NavController
    private lateinit var appComponent: AppComponent
    private var notificationCount = 0

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
        menuInflater.inflate(R.menu.main_menu, menu)
        val menuItem = menu?.findItem(R.id.itemNotificationAction)
        val actionView = menuItem?.actionView
        actionView?.setOnClickListener { onOptionsItemSelected(menuItem) }
        setupBadge()
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.itemNotificationAction -> {
                navController.navigate(R.id.notificationFragment)
                return true
            }
        }
        return super.onOptionsItemSelected(item)
    }

    fun setupBadge() {
        if (notification_badge != null) {
            if (notificationCount == 0) {
                notification_badge.visibility = View.GONE
            } else {
                notification_badge.text = Math.min(notificationCount, 99).toString()
                notification_badge.visibility = View.VISIBLE
            }
        }
    }

    override fun onSupportNavigateUp(): Boolean {
        return navController.navigateUp() || super.onSupportNavigateUp()
    }

    fun setNotificationCount(notificationCount: Int){
        this.notificationCount = notificationCount
    }

    fun getAppComponent() = appComponent

    fun hideBottomNav() {
        navigationBarBottom.visibility = View.GONE
    }

    fun showBottomNav() {
        navigationBarBottom.visibility = View.VISIBLE
    }
}