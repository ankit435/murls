# Generated by Django 3.2.6 on 2021-08-28 06:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("urls", "0005_alter_url_location"),
    ]

    operations = [
        migrations.AlterField(
            model_name="url",
            name="location",
            field=models.URLField(max_length=6000),
        ),
        migrations.AlterField(
            model_name="url",
            name="name",
            field=models.CharField(blank=True, max_length=50),
        ),
    ]
