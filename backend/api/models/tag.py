from django.db import models
from api.models.project import Project


class Tag(models.Model):
    """
    Tag model for project tags.
    """
    name = models.CharField(max_length=500, blank=False)
    projects = models.ManyToManyField(Project)

    class Meta:
        ordering = ['name']
