from django.db import models


class Project(models.Model):
    """
    Project model for projects.
    """
    created = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=500, blank=False)
    description = models.TextField(default='')
    requirements = models.TextField(default='')
    is_public = models.BooleanField(default=False)
    owner = models.ForeignKey('auth.User', related_name='owner', on_delete=models.CASCADE)
    members = models.ManyToManyField('auth.User', related_name='members')

    class Meta:
        ordering = ['created']
