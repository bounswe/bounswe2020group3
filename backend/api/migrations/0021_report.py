# Generated by Django 3.1.4 on 2021-01-21 12:39

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('api', '0020_auto_20210117_1512'),
    ]

    operations = [
        migrations.CreateModel(
            name='Report',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('report_type', models.CharField(choices=[('Disturbing other users', '0'), ('Sharing unrelated or disturbing posts', '1'), ('Spam', '2'), ('Fake Profile', '3'), ('Stolen Account', '4')], default='Spam', max_length=100)),
                ('description', models.CharField(max_length=1000, null=True)),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
                ('reported_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reports', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['reported_user'],
            },
        ),
    ]
