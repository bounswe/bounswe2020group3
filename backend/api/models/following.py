from django.db import models


class Following(models.Model):
    """
    Following model for follows.
    """
    from_user = models.ForeignKey('auth.User',
                                  related_name="following",
                                  on_delete=models.CASCADE)
    to_user = models.ForeignKey('auth.User',
                                related_name="followers",
                                on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['from_user',
                                            'to_user'],
                                    name="unique_followers")
        ]
        ordering = ['created']


class FollowRequest(models.Model):
    req_from_user = models.ForeignKey('auth.User',
                                      related_name="sent_requests",
                                      on_delete=models.CASCADE)
    req_to_user = models.ForeignKey('auth.User',
                                    related_name="incoming_requests",
                                    on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['req_from_user',
                                            'req_to_user'],
                                    name="unique_request")
        ]
        ordering = ['created']

    def accept(self):
        Following.objects.create(from_user=self.req_from_user,
                                 to_user=self.req_to_user).save()
        self.delete()
        FollowRequest.objects.filter(
            req_from_user=self.req_to_user,
            req_to_user=self.req_from_user
        ).delete()
        # TODO add notification signal

    def reject(self):
        self.delete()
        # TODO add notification signal2
