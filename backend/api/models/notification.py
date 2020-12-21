from notifications.base.models import AbstractNotification
from django.contrib.contenttypes.fields import GenericForeignKey


class Notification(AbstractNotification):

    invite = GenericForeignKey('target_content_type', 'target_object_id')
    request = GenericForeignKey('target_content_type', 'target_object_id')
    follow = GenericForeignKey('target_content_type', 'target_object_id')
    project = GenericForeignKey('target_content_type', 'target_object_id')

    class Meta(AbstractNotification.Meta):
        abstract = False
        app_label = 'api'
