from django.shortcuts import render

from django.conf import settings

def index(request):
    production = settings.PRODUCTION

    return render(request, template_name="index.html", context={'production': production})
