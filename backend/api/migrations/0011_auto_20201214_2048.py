# Generated by Django 3.1.3 on 2020-12-14 17:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0010_merge_20201214_2048'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='profile',
            name='photo_url',
        ),
        migrations.AddField(
            model_name='profile',
            name='affiliations',
            field=models.TextField(blank=True, default=''),
        ),
        migrations.AddField(
            model_name='profile',
            name='profile_picture',
            field=models.ImageField(blank=True, null=True, upload_to=''),
        ),
    ]
