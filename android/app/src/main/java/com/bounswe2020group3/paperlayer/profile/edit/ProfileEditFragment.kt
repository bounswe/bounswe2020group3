package com.bounswe2020group3.paperlayer.profile.edit

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.Navigation
import com.bounswe2020group3.paperlayer.MainActivity
import com.bounswe2020group3.paperlayer.R
import com.bounswe2020group3.paperlayer.profile.data.Profile
import com.bounswe2020group3.paperlayer.data.user.User
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.fragment_profile_edit.*
import kotlinx.android.synthetic.main.fragment_profile_edit.imageViewProfileAvatar
import javax.inject.Inject


class ProfileEditFragment : Fragment(), ProfileEditContract.View {

    @Inject
    lateinit var presenter: ProfileEditContract.Presenter

    private lateinit var genderSelectDialog: MaterialAlertDialogBuilder
    private var selectedGender: String? = null

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

        imageButtonSave.setOnClickListener{
            val userData = presenter.getUserData()
            if(userData != null) {
                val profileData = userData.profile.first()
                if(profileData != null) {
                    profileData.name = editTextFirstName.text.toString()
                    profileData.lastName = editTextLastName.text.toString()
                    profileData.expertise = editTextExpertise.text.toString()
                    profileData.interests = editTextInterests.text.toString()
                    profileData.birthday = editTextBirthday.text.toString()
                    profileData.bio = editTextBio.text.toString()
                    profileData.gender = selectedGender
                    presenter.updateProfile(profileData)
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

        buttonGenderSelect.setOnClickListener{
            genderSelectDialog.show()
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
        if(imageUrl != null && imageUrl.contains("http")) {
            Picasso.get().load(imageUrl).into(imageViewProfileAvatar)
        }
    }

    override fun navigateBack() {
        Navigation.findNavController(requireView()).navigateUp()
    }

}