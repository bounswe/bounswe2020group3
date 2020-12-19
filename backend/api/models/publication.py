from django.db import models


class Publication(models.Model):
    """
    Publication model
    """
    title = models.CharField(max_length=100, blank=False)
    publication_year = models.IntegerField(default=0)
    abstract = models.TextField(default='')
    authors = models.TextField(default='')
    journal = models.CharField(max_length=100, blank=False)
    citation_number = models.IntegerField(default=0)

    class Meta:
        ordering = ['citation_number']
