from django.db import models


class Comment(models.Model):
    """
    Comment model for comments.
    """
    from_user = models.ForeignKey('auth.User',
                                  related_name="comments_made",
                                  on_delete=models.CASCADE,
                                  )
    to_user = models.ForeignKey('auth.User',
                                related_name="comments_received",
                                on_delete=models.CASCADE,
                                )
    created = models.DateTimeField(auto_now_add=True)
    comment = models.CharField(max_length=1000)

    class Meta:
        ordering = ['created']
