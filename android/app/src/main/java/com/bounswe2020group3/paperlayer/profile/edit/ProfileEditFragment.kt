package com.bounswe2020group3.paperlayer.profile.edit

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.provider.OpenableColumns
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.data.user.Profile
import com.bounswe2020group3.paperlayer.data.user.User
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.fragment_profile.*
import kotlinx.android.synthetic.main.fragment_profile_edit.*
import kotlinx.android.synthetic.main.fragment_profile_edit.imageViewProfileAvatar
import okhttp3.MediaType
import java.io.File
import java.io.FileOutputStream
import javax.inject.Inject


class ProfileEditFragment : Fragment(), ProfileEditContract.View {

    private val SELECT_PHOTO = 1

    @Inject
    lateinit var presenter: ProfileEditContract.Presenter

    private lateinit var genderSelectDialog: MaterialAlertDialogBuilder
    private var selectedGender: String? = null
    private var profile: Profile? = null

    override fun onAttach(context: Context) {
        super.onAttach(context)
        (context as MainActivity).getAppComponent().inject(this)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        presenter.bind(this)
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_profile_edit, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        presenter.subscribeUser()

        imageButtonSave.setOnClickListener {
            val userData = presenter.getUserData()
            if (userData != null) {
                try {
                    val profileData = userData.profile.first()
                    profileData.name = editTextFirstName.text.toString()
                    profileData.lastName = editTextLastName.text.toString()
                    profileData.expertise = editTextExpertise.text.toString()
                    profileData.interests = editTextInterests.text.toString()
                    profileData.birthday = editTextBirthday.text.toString()
                    profileData.bio = editTextBio.text.toString()
                    profileData.gender = selectedGender

                    // Don't send profile_picture field because it expects a file.
                    // Profile picture is updated with another endpoint
                    profileData.profile_picture = null

                    presenter.updateProfile(profileData)
                } catch (e: NoSuchElementException) {
                    e.printStackTrace()
                    showErrorToast("An error occurred. Please try again.")
                    navigateBack()
                }
            }
        }

        val genderOptions = arrayOf("male", "female", "do not want to share")
        genderSelectDialog = MaterialAlertDialogBuilder(requireContext())
                .setTitle(R.string.profile_gender_dialog_title)
                .setItems(genderOptions) { _, which ->
                    selectedGender = genderOptions[which]
                    val genderText = "Gender: $selectedGender"
                    buttonGenderSelect.text = genderText
                }

        buttonGenderSelect.setOnClickListener {
            genderSelectDialog.show()
        }

        // Update profile picture
        imageViewProfileAvatar.setOnClickListener {
            if (this.profile != null) {
                val intent: Intent = Intent(Intent.ACTION_PICK)
                intent.type = "image/*"
                startActivityForResult(intent, SELECT_PHOTO)
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (profile != null && requestCode == SELECT_PHOTO &&
                resultCode == Activity.RESULT_OK && data != null && data.data != null) {
            try {
                val activity = requireActivity()
                val uri = data.data!!
                val contentResolver = activity.contentResolver
                val imageType = contentResolver.getType(uri)!!
                val mediaType = MediaType.parse(imageType)!!

                // Create a temporary path name to the file
                val inputStream = contentResolver.openInputStream(uri)!!
                var pathName = ""
                val cursor = contentResolver.query(uri, null, null, null)
                cursor?.use {
                    it.moveToFirst()
                    pathName = cursor.getString(it.getColumnIndex(OpenableColumns.DISPLAY_NAME))
                }
                val file = File(activity.cacheDir, pathName)
                val outputStream = FileOutputStream(file)
                inputStream.copyTo(outputStream)

                presenter.updateProfilePicture(profile!!.id, file, mediaType)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        presenter.unbind()
    }

    override fun onResume() {
        super.onResume()
        presenter.loadUser()
    }

    override fun showLoading() {
        progressBarProfileEdit.visibility = View.VISIBLE
        scrollViewProfileEdit.visibility = View.GONE
    }

    override fun hideLoading() {
        progressBarProfileEdit.visibility = View.GONE
        scrollViewProfileEdit.visibility = View.VISIBLE
    }

    override fun showErrorToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_LONG).show()
    }

    override fun showInfoToast(message: String) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }

    override fun updateProfileUI(user: User) {
        val profile = user.profile[0]
        updateProfileUIWithProfile(profile)
    }

    override fun updateProfileUIWithProfile(profile: Profile) {
        this.profile = profile
        editTextFirstName.setText(profile.name)
        editTextLastName.setText(profile.lastName)
        editTextExpertise.setText(profile.expertise)
        editTextInterests.setText(profile.interests)
        editTextBirthday.setText(profile.birthday.toString())
        editTextBio.setText(profile.bio)

        val genderText = "Gender: ${profile.gender}"
        buttonGenderSelect.text = genderText
        selectedGender = profile.gender

        val imageUrl = profile.profile_picture
        if (imageUrl != null && imageUrl != "") {
            Picasso.get().load(imageUrl).into(imageViewProfileAvatar)
        }
    }

    override fun navigateBack() {
        Navigation.findNavController(requireView()).navigateUp()
    }

}