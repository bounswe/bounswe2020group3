from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase
from api.models.project import Project
from django.test.utils import setup_test_environment
import json


class CollaborationRequestTests(APITestCase):
    """
    Tests for the project model.
    """

    def setUp(self):
        self.owner = User.objects.create_user(
            username='jane_doe', email='jane_doe@…', password='1234_secret')
        self.requesting_user = User.objects.create_user(
            username='mehmet', email='mehmet@…', password='1234_secret')
        self.project = Project.objects.create(
            name='Academic Project',
            description='This is an academic project.',
            owner=self.owner, due_date="2020-12-15")

    def test_can_create_collaboration_request(self):
        self.client.force_authenticate(user=self.requesting_user)
        response = self.client.post('/api/collaboration_requests/',
                                    {'to_project': self.project.id},
                                    format='json')
        self.assertEqual(response.status_code, 201)

        self.client.force_authenticate(user=self.owner)
        response = self.client.get(
            '/api/collaboration_requests/', {'to_user__id': self.owner.id})
        json_obj = json.loads(response.content.decode('utf-8')[1:-1])
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(json_obj['from_user'], self.requesting_user.id)

        url = '/api/collaboration_requests/' + \
            str(json_obj['id'])+'/accept_collaboration/'
        response = self.client.post(url,
                                    {'to_project': self.project.id},
                                    format='json')
        self.assertEqual(response.status_code, 201)
        #response = self.client.get('/api/projects/1/')
        #self.assertEqual(response.content, 201)

        response = self.client.get(
            '/api/collaboration_requests/', {'to_user__id': self.owner.id})
        self.assertEqual(response.content.decode('utf-8'), '[]')
