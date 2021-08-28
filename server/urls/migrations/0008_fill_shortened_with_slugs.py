from django.db import migrations, models

from utils.base_url import get_full_base_url



def fill_shortened_field(apps, schema_editor):
    """
    fill shortened field with base`base_url + slug`
    """
    base_url = get_full_base_url()
    UrlModel = apps.get_model("urls", "Url")
    for row in UrlModel.objects.all():
        row.shortened = base_url + "/" + row.slug
        row.save(update_fields=["shortened"])


class Migration(migrations.Migration):

    dependencies = [
        ("urls", "0007_url_shortened"),
    ]

    operations = [
        migrations.AlterField(
            model_name="url",
            name="shortened",
            field=models.URLField(max_length=2000),
        ),
        migrations.RunPython(
            fill_shortened_field, reverse_code=migrations.RunPython.noop
        ),
    ]
