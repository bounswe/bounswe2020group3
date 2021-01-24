from django.db import models


class Publication(models.Model):
    """
    Publication model
    """
    title = models.CharField(max_length=1000)
    publication_year = models.IntegerField(default=0)
    link = models.TextField(default='')
    citation_number = models.IntegerField(default=0)
    owner = models.ForeignKey(
        'auth.User', related_name='publication_owner',
        on_delete=models.CASCADE)

    class Meta:
        ordering = ['citation_number']
