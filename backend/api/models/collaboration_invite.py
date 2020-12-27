from django.db import models
from .project import Project
from django.utils import timezone


class CollaborationInvite(models.Model):
    from_user = models.ForeignKey(
        'auth.User',
        on_delete=models.CASCADE,
        related_name="collab_invite_sent",
    )
    to_user = models.ForeignKey(
        'auth.User',
        on_delete=models.CASCADE,
        related_name="collab_invite_received",
    )
    to_project = models.ForeignKey(
        Project,
        on_delete=models.CASCADE,
        related_name="collab_invite_of_project"
    )
    message = models.CharField(max_length=200, blank=True, default='')
    created = models.DateTimeField(blank=True, null=True)
    rejected = models.DateTimeField(blank=True, null=True)

    class Meta:
        ordering = ['created']

    def accept(self):
        self.to_project.members.add(self.to_user)
        self.delete()
        # TODO add notification signal

    def reject(self):
        self.rejected = timezone.now()
        self.save()
        # TODO add notification signal
