from django.db import models
from .profile import Profile


class Publication(models.Model):
    """
    Publication model
    """
    title = models.CharField(max_length=1000)
    publication_year = models.IntegerField(default=0)
    abstract = models.TextField(default='')
    authors = models.TextField(default='')
    journal = models.TextField(default='')
    citation_number = models.IntegerField(default=0)
    profile = models.ForeignKey(Profile, on_delete=models.CASCADE)

    class Meta:
        ordering = ['citation_number']
