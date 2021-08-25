from rest_framework.serializers import (
    ModelSerializer,
    ValidationError,
    CharField as serializer_CharField,
)

from urls.models import Url


def slug_validation_error():
    raise ValidationError("The Slug provided was invalid")


class UrlSerializer(ModelSerializer):
    slug = serializer_CharField(allow_blank=True,required=False)
    class Meta:
        model = Url
        fields = (
            "id",
            "name",
            "description",
            "location",
            "boosted",
            "slug",
            "created_at",
            "updated_at"
        )
        read_only_fields = ("id","created_at", "updated_at")

    def validate_slug(self, value: str):
        if " " in value:
            slug_validation_error()
        # later add the setting from admin
        return value
