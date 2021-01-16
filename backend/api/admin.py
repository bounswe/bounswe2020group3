from django.contrib import admin
from .models.example import Example

# Register your models here.
from .models.following import Following, FollowRequest
from .models.profile import Profile
from .models.project import Project
from .models.event import Event
from .models.file import File
from .models.collaboration_invite import CollaborationInvite
from .models.collaboration_request import CollaborationRequest
from .models.comment import Comment
from .models.rating import Rating
from .models.tag import Tag

admin.site.register(Example)
admin.site.register(Profile)
admin.site.register(Project)
admin.site.register(Event)
admin.site.register(File)
admin.site.register(Following)
admin.site.register(FollowRequest)
admin.site.register(CollaborationInvite)
admin.site.register(CollaborationRequest)
admin.site.register(Comment)
admin.site.register(Rating)
admin.site.register(Tag)
