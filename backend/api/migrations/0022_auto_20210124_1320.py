# Generated by Django 3.1.4 on 2021-01-24 10:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0021_merge_20210117_2302'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='publication',
            name='abstract',
        ),
        migrations.RemoveField(
            model_name='publication',
            name='authors',
        ),
        migrations.RemoveField(
            model_name='publication',
            name='journal',
        ),
        migrations.AddField(
            model_name='publication',
            name='link',
            field=models.TextField(default=''),
        ),
    ]
