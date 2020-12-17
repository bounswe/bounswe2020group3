# Generated by Django 3.1.3 on 2020-12-12 13:33

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('api', '0008_auto_20201206_2028'),
    ]

    operations = [
        migrations.CreateModel(
            name='FollowRequest',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('req_from_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sent_requests', to=settings.AUTH_USER_MODEL)),
                ('req_to_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='incoming_requests', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['created'],
            },
        ),
        migrations.CreateModel(
            name='Following',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('from_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='following', to=settings.AUTH_USER_MODEL)),
                ('to_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='followers', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['created'],
            },
        ),
        migrations.AddConstraint(
            model_name='followrequest',
            constraint=models.UniqueConstraint(fields=('req_from_user', 'req_to_user'), name='unique_request'),
        ),
        migrations.AddConstraint(
            model_name='following',
            constraint=models.UniqueConstraint(fields=('from_user', 'to_user'), name='unique_followers'),
        ),
    ]
