package com.bounswe2020group3.paperlayer

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val navController = findNavController(R.id.fragment)
        val appBarConfiguration = AppBarConfiguration(setOf(
            R.id.mainFragment, R.id.projectFragment, R.id.profileFragment
        ))
        setupActionBarWithNavController(navController, appBarConfiguration)

        navigationBarBottom.setupWithNavController(navController)

    }
}