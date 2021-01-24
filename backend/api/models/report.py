from django.db import models

REPORT_TYPES = ["Disturbing other users",
                "Sharing unrelated or disturbing posts",
                "Spam", "Fake Profile", "Stolen Account"]
TYPE_CHOICES = [(REPORT_TYPES[i], str(i)) for i in range(len(REPORT_TYPES))]


class Report(models.Model):
    """
    Report model for project files.
    """
    reported_user = models.ForeignKey(
        'auth.User', related_name='reports', on_delete=models.CASCADE)
    report_type = models.CharField(choices=TYPE_CHOICES,
                                   default="Spam", max_length=100)
    description = models.CharField(max_length=1000, null=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['reported_user']
