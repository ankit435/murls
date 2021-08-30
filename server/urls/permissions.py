from rest_framework.permissions import BasePermission


class IsUrlOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        return request.user == obj.creator
