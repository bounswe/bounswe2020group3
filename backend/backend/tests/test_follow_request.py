from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase


class FollowRequestTests(APITestCase):
    """
    Tests for the following model.
    """

    def setUp(self):
        self.requesting_user = User.objects.create_user(
            username='jane_doe', email='jane_doe@…', password='1234_secret')
        self.other_user = User.objects.create_user(
            username='mehmet', email='mehmet@…', password='1234_secret')

    def test_sent_follow_request(self):
        self.client.force_authenticate(user=self.requesting_user)
        response = self.client.post('/api/follow_request/',
                                    {'req_to_user': self.other_user.id},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
