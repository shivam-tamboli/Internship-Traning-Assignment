from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view
from rest_framework.response import Response

@api_view(['GET'])
def dashboard_data(request):
    data = {
        "total_revenue": 125000,
        "total_orders": 320,
        "top_products": [
            {"name": "Laptop", "sales": 50},
            {"name": "Phone", "sales": 80},
            {"name": "Headphones", "sales": 40},
        ],
        "monthly_revenue": [
            {"month": "Jan", "revenue": 20000},
            {"month": "Feb", "revenue": 30000},
            {"month": "Mar", "revenue": 25000},
        ]
    }
    return Response(data)