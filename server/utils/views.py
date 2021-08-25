from django.http import JsonResponse

# will be shown when Debug=False in settings
def Page_Not_Found(request, exception=None):
    return JsonResponse({"message": "Page Not Found", "status_code": 404})
