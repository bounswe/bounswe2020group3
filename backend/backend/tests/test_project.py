from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase
import json


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

    def test_owner_added_to_members(self):
        response = self.client.post('/api/projects/',
                                    {'name': 'Academic Project',
                                     'description': 'This is an \
                                         academic project.',
                                     'state': 'open for collaborators',
                                     'due_date': '2020-12-15'},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        response = self.client.get('/api/projects/1/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        json_obj = json.loads(response.content.decode('utf-8'))
        self.assertEqual(json_obj['members'][0]['id'], self.user.id)
