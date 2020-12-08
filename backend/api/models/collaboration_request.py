from django.db import models
from .project import Project
from django.utils import timezone


class CollaborationRequest(models.Model):
    from_user = models.ForeignKey(
        'auth.User',
        on_delete=models.CASCADE,
        related_name="collab_request_sent",
    )
    to_user = models.ForeignKey(
        'auth.User',
        on_delete=models.CASCADE,
        related_name="collab_request_received",
    )
    to_project = models.ForeignKey(
        Project,
        on_delete=models.CASCADE,
        related_name="collab_request_of_project"
    )
    message = models.CharField(max_length=200, blank=True, default='')
    created = models.DateTimeField(auto_now_add=True)
    rejected = models.DateTimeField(blank=True, null=True)

    class Meta:
        ordering = ['created']

    def accept(self):
        self.to_project.members.add(self.from_user)
        self.delete()
        CollaborationRequest.objects.filter(
            from_user=self.to_user,
            to_user=self.from_user,
            to_project=self.to_project
        ).delete()
        # TODO add notification signal

    def reject(self):
        self.rejected = timezone.now()
        self.save()
        # TODO add notification signal
