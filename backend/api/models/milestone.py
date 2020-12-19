from django.db import models
from api.models.project import Project


class Milestone(models.Model):
    """
    Milestone model for project milestones.
    """
    description = models.TextField(default='')
    date = models.DateField()
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='milestones')

    class Meta:
        ordering = ['project']
