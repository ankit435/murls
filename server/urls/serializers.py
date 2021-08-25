from rest_framework.serializers import ModelSerializer, ValidationError
from urllib.parse import urlparse

from urls.models import Url


def slug_validation_error():
    raise ValidationError("The Slug provided was invalid")


class UrlSerializer(ModelSerializer):
    class Meta:
        model = Url
        fields = ("name", "description", "location", "boosted", "slug")
        read_only_fields = ("created_at", "updated_at")

    def validate_slug(self, value: str):
        if " " in value:
            slug_validation_error()
        # later add the setting from admin
        return value
