from django.db import models

GENDERS = ["male", "female", "do not want to share"]
GENDER_CHOICES = [(str(i), GENDERS[i]) for i in range(len(GENDERS))]


class Profile(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=100, blank=False, default='')
    middle_name = models.CharField(max_length=100, blank=True, default='')
    last_name = models.CharField(max_length=100, blank=False, default='')
    bio = models.CharField(max_length=1000, blank=True, default='')
    photo_url = models.TextField(default='')
    age = models.IntegerField(default=0)
    share_age = models.BooleanField(default=True)
    expertise = models.TextField(default='')
    gender = models.CharField(choices=GENDER_CHOICES, default='friendly', max_length=100)
    interests = models.TextField(default='')
    owner = models.ForeignKey('auth.User', related_name='snippets', on_delete=models.CASCADE)

    class Meta:
        ordering = ['created']
