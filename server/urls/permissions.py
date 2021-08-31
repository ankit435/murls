from rest_framework.permissions import BasePermission
from rest_framework.exceptions import NotFound

from urls.models import Url


class IsUrlOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        return request.user == obj.creator


class IsUrlTrackOwner(BasePermission):
    def has_permission(self, request, view):
        try:
            url = Url.objects.only("creator").get(id=view.kwargs.get("id"))
            return request.user == url.creator
        except:
            raise NotFound("The Url with this id does not exist")
