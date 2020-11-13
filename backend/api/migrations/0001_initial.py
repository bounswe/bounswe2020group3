# Generated by Django 3.1.3 on 2020-11-08 21:52

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Example',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('description', models.CharField(max_length=255)),
                ('created_date', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='Profile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('name', models.CharField(default='', max_length=100)),
                ('middle_name', models.CharField(blank=True, default='', max_length=100)),
                ('last_name', models.CharField(default='', max_length=100)),
                ('bio', models.CharField(blank=True, default='', max_length=1000)),
                ('photo_url', models.TextField(default='')),
                ('age', models.IntegerField(default=0)),
                ('share_age', models.BooleanField(default=True)),
                ('expertise', models.TextField(default='')),
                ('gender', models.CharField(choices=[('0', 'male'), ('1', 'female'), ('2', 'do not want to share')], default='friendly', max_length=100)),
                ('interests', models.TextField(default='')),
                ('owner', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='profiles', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['created'],
            },
        ),
    ]