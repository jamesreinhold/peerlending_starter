# Generated by Django 3.1.8 on 2021-04-18 10:17

from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='first_name',
            field=models.CharField(blank=True, help_text='Legal First names of the client.', max_length=125, null=True, verbose_name='First names'),
        ),
        migrations.AddField(
            model_name='user',
            name='last_name',
            field=models.CharField(blank=True, help_text='Legal Last names of the client.', max_length=125, null=True, verbose_name='Last names'),
        ),
        migrations.AlterField(
            model_name='user',
            name='id',
            field=models.UUIDField(default=uuid.uuid4, editable=False, help_text='The unique identifier of the instance this object belongs to.\n                    Mandatory, unless a new instance to create is given.', primary_key=True, serialize=False),
        ),
    ]
