from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator


class Rating(models.Model):
    """
    Rating model for ratings.
    """
    from_user = models.ForeignKey('auth.User',
                                  related_name="ratings_made",
                                  on_delete=models.CASCADE,
                                  )
    to_user = models.ForeignKey('auth.User',
                                related_name="ratings_received",
                                on_delete=models.CASCADE,
                                )
    created = models.DateTimeField(auto_now_add=True)
    rating = models.IntegerField(validators=[MaxValueValidator(10),
                                             MinValueValidator(0)])

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['from_user',
                                            'to_user'],
                                    name="unique_rating")
        ]
        ordering = ['created']
