from django.db import models


class Following(models.Model):
    """
    Following model for follows.
    """
    from_user = models.ForeignKey('auth.User', related_name="following",
                                  on_delete=models.CASCADE)
    to_user = models.ForeignKey('auth.User', related_name="followers",
                                on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['from_user', 'to_user'],
                                    name="unique_followers")
        ]
        ordering = ['created']
