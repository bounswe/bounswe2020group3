from django.db import models
from api.models.project import Project
import os


class File(models.Model):
    """
    File model for project files.
    """
    file = models.FileField(blank=False, null=False,
                            upload_to='files/')
    remark = models.CharField(max_length=20)
    timestamp = models.DateTimeField(auto_now_add=True)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)

    class Meta:
        ordering = ['project']

    def delete(self, *args, **kwargs):
        if os.path.isfile(self.file.path):
            os.remove(self.file.path)

        super(File, self).delete(*args, **kwargs)
