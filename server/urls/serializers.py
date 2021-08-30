from rest_framework.serializers import (
    ModelSerializer,
    ValidationError,
    Serializer,
    CharField as serializer_CharField,
    IntegerField as serializer_IntegerField,
    DateTimeField as serializer_DateTimeField,
)
from rest_framework import serializers
from urls.models import Url, UrlTrack


def slug_validation_error():
    raise ValidationError("The Slug provided was invalid")


class UrlSerializer(ModelSerializer):
    slug = serializer_CharField(allow_blank=True, required=False)

    class Meta:
        model = Url
        fields = (
            "id",
            "name",
            "location",
            "boosted",
            "clicks",
            "slug",
            "expiry_date",
            "created_at",
            "updated_at",
        )
        read_only_fields = ("id", "clicks", "created_at", "updated_at")

    def validate_slug(self, value: str):
        if " " in value:
            slug_validation_error()
        # later add the setting from admin
        return value


class UrlTrackSerializer(ModelSerializer):
    class Meta:
        model = UrlTrack
        fields = ("id", "ip_address", "when")


class GraphSerializer(serializers.Serializer):
    count = serializer_IntegerField()
    on = serializer_DateTimeField()
