from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase


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

    def test_can_create_profile(self):
        response = self.client.post('/api/profiles/',
                                    {'bio': 'very important person',
                                     'gender': 'male'}, format='json')
        self.assertEqual(response.status_code, 201)

    def test_can_read_profile_list(self):
        response = self.client.get(reverse('profile-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
