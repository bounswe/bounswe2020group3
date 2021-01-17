from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase


class TagTests(APITestCase):
    """
        Tests for the tag model.
    """

    def setUp(self):
        self.username = 'john_doe'
        self.password = 'foobar'
        self.user = User.objects.create(username=self.username,
                                        password=self.password)
        self.client.force_authenticate(user=self.user)

    def test_can_create_tag(self):
        response = self.client.post('/api/tags/',
                                    {'name': 'Machine Learning'},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_can_not_create_same_tag(self):
        response = self.client.post('/api/tags/',
                                    {'name': 'Natural Language Processing'},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        response = self.client.post('/api/tags/',
                                    {'name': 'Natural Language Processing'},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
