from django.contrib import admin
from .models.example import Example

# Register your models here.
from .models.profile import Profile

admin.site.register(Example)
admin.site.register(Profile)
