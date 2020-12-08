from django.db import models


class Tag(models.Model):
    """
    Tag model for project tags.
    """
    name = models.CharField(max_length=500, blank=False)

    class Meta:
        ordering = ['name']
