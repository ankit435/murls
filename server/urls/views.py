from rest_framework.response import Response
from rest_framework.views import APIView


class URLView(APIView):
    def get(self, _request):
        return Response(data={"health": "working"})
