package com.bounswe2020group3.paperlayer

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        navigationBarBottom.setOnNavigationItemSelectedListener {
            when(it.itemId){
                R.id.itemHome -> showToast("Home")
                R.id.itemProfile -> showToast("Profile")
                R.id.itemProjects -> showToast("Projects")
                else -> false
            }
        }
    }

    private fun showToast(message: String): Boolean {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
        return true
    }
}