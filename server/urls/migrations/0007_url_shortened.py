# Generated by Django 3.2.6 on 2021-08-28 07:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("urls", "0006_auto_20210828_0640"),
    ]

    operations = [
        migrations.AddField(
            model_name="url",
            name="shortened",
            field=models.URLField(default="", max_length=2000),
        ),
    ]
