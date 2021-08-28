from rest_framework.views import APIView
from rest_framework.response import Response


class PrivateView(APIView):
    def get(self, request):
        return Response(data={"message": "accessing private"})
