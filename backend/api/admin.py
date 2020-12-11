from django.contrib import admin

# Register your models here.
from .models.profile import Profile
from .models.project import Project
from .models.event import Event
from .models.file import File

admin.site.register(Profile)
admin.site.register(Project)
admin.site.register(Event)
admin.site.register(File)
