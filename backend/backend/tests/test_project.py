from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase


class ProjectTests(APITestCase):
    """
    Tests for the project model.
    """
    def setUp(self):
        self.username = 'john_doe'
        self.password = 'foobar'
        self.user = User.objects.create(username=self.username,
                                        password=self.password)
        self.client.force_authenticate(user=self.user)

    def test_can_read_project_list(self):
        response = self.client.get('/api/projects/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
