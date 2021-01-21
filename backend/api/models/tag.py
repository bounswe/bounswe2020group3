from django.db import models
import random


def random_color():
    return random.randint(0, 9)


class Tag(models.Model):
    """
    Tag model for project tags.
    """
    name = models.CharField(max_length=500, blank=False, unique=True)
    color = models.IntegerField(default=random_color)

    class Meta:
        ordering = ['name']
