from django.db import models


class Example(models.Model):
    name = models.CharField(max_length=255, unique=True, null=False)
    description = models.CharField(max_length=255, null=False)
    created_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name
