from django.db import models
import datetime
from .event import Event
from .tag import Tag

STATES = ["draft", "inviting collaborators", "open for collaborators",
          "in progress", "submitted to event", "published", "cancelled",
          "done", "reopened"]
STATE_CHOICES = [(STATES[i], str(i)) for i in range(len(STATES))]
PROJECT_TYPES = ["conference", "instutution", "journal"]
TYPE_CHOICES = [(PROJECT_TYPES[i], str(i)) for i in range(len(PROJECT_TYPES))]


class Project(models.Model):
    """
    Project model for projects.
    """
    created = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=500, blank=False)
    description = models.TextField(default='')
    requirements = models.TextField(default='')
    is_public = models.BooleanField(default=False)
    owner = models.ForeignKey(
        'auth.User', related_name='owner', on_delete=models.CASCADE)
    members = models.ManyToManyField('auth.User', related_name='members',
                                     blank=True)
    state = models.CharField(choices=STATE_CHOICES,
                             default="draft",
                             max_length=100)
    project_type = models.CharField(choices=TYPE_CHOICES,
                                    default="conference", max_length=100)
    due_date = models.DateField(default=datetime.date.today)
    event = models.ForeignKey(
        Event, blank=True, on_delete=models.SET_NULL, null=True)
    tags = models.ManyToManyField(Tag, blank=True)

    class Meta:
        ordering = ['created']
