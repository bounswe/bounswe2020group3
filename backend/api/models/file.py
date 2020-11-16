from django.db import models
from api.models.project import Project


class File(models.Model):
    """
    File model for project files.
    """
    file = models.FileField(blank=False, null=False)
    remark = models.CharField(max_length=20)
    timestamp = models.DateTimeField(auto_now_add=True)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)

    class Meta:
        ordering = ['project']
