from django.db import models

GENDERS = ["male", "female", "do not want to share"]
GENDER_CHOICES = [(GENDERS[i], str(i)) for i in range(len(GENDERS))]


class Profile(models.Model):
    """
    Profile model for user profiles
    """
    created = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=100, blank=False, default='')
    middle_name = models.CharField(max_length=100, blank=True, default='')
    last_name = models.CharField(max_length=100, blank=False, default='')
    bio = models.CharField(max_length=1000, blank=True, default='')
    profile_picture = models.ImageField(null=True, blank=True)
    birthday = models.DateField(blank=True, null=True)
    share_birthday = models.BooleanField(default=True)

    expertise = models.TextField(default='', blank=True)
    gender = models.CharField(choices=GENDER_CHOICES,
                              default="do not want to share", max_length=100)
    interests = models.TextField(default='', blank=True)
    affiliations = models.TextField(default='', blank=True)
    owner = models.ForeignKey(
        'auth.User', related_name='profile', on_delete=models.CASCADE)
    share_bio = models.BooleanField(default=True)
    share_gender = models.BooleanField(default=True)
    share_affiliations = models.BooleanField(default=True)

    class Meta:
        ordering = ['created']
