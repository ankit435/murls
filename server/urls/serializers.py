from rest_framework.serializers import ModelSerializer, ValidationError
from urllib.parse import urlparse

from urls.models import Url

def url_validation_error():
    raise ValidationError("Invalid URL was provided for location")

class UrlSerializer(ModelSerializer):

    class Meta:
        model = Url
        fields = ('name','description','location','boosted')
        read_only_fields = ('created_at','updated_at')

    

        