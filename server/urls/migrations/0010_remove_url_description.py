# Generated by Django 3.2.6 on 2021-08-29 18:45

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("urls", "0009_url_expiry_date"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="url",
            name="description",
        ),
    ]
