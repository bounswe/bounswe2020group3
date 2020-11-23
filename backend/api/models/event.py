from django.db import models

TYPES = ["journal submission", "academic conference", "funded project"]
TYPE_CHOICES = [(TYPES[i], str(i)) for i in range(len(TYPES))]


class Event(models.Model):
    """
    Event model
    """
    title = models.CharField(max_length=100, blank=False)
    description = models.CharField(max_length=200, blank=True, default='')
    deadline = models.DateField(blank=False)
    date = models.DateField(blank=False)
    event_type = models.CharField(
        choices=TYPE_CHOICES, blank=False, max_length=50)
    url = models.URLField(blank=True, default='')

    class Meta:
        ordering = ['date']
