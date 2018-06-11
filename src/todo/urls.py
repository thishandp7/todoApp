from django.conf.urls import url, include
from todo import views
from rest_framework.routers import DefaultRouter
from django.urls import path

router = DefaultRouter(trailing_slash=False)
router.register('todos', views.TodoItemViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
