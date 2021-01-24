from django.contrib.auth.models import User
from rest_framework.test import APITestCase
from rest_framework import status


class ProfileTests(APITestCase):
    """
        Tests for the profile model.
    """

    def setUp(self):
        self.username = 'john_doe'
        self.password = 'foobar'
        self.user = User.objects.create(username=self.username,
                                        password=self.password)
        self.client.force_authenticate(user=self.user)

    def test_can_add_publiciations(self):
        response = self.client.get(
            '/api/publications/?owner_id=1')
        self.assertEqual(response.content.decode('utf-8'), '[]')
        response = self.client.post(
            '/api/publications/add_publications/' +
            '?author_id=B23iqYwAAAAJ')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        response = self.client.get(
            '/api/publications/?owner_id=1')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertNotEqual(response.content.decode('utf-8'), '[]')

    def test_can_get_publications(self):
        response = self.client.get('/api/publications/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
