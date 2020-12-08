from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase
from api.models.project import Project
import json


class CollaborationInviteTests(APITestCase):
    """
    Tests for the project model.
    """

    def setUp(self):
        self.owner = User.objects.create_user(
            username='jane_doe', email='jane_doe@…', password='1234_secret')
        self.invited_user = User.objects.create_user(
            username='mehmet', email='mehmet@…', password='1234_secret')
        self.project = Project.objects.create(
            name='Academic Project',
            description='This is an academic project.',
            owner=self.owner, due_date="2020-12-15")

    def test_can_create_collaboration_invite(self):
        self.client.force_authenticate(user=self.owner)
        response = self.client.post('/api/collaboration_invites/',
                                    {'to_project': self.project.id,
                                     'to_user': self.invited_user.id},
                                    format='json')
        self.assertEqual(response.status_code, 201)

        self.client.force_authenticate(user=self.invited_user)
        response = self.client.get(
            '/api/collaboration_invites/',
            {'to_user__id': self.invited_user.id})
        json_obj = json.loads(response.content.decode('utf-8')[1:-1])
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(json_obj['from_user'], self.owner.id)

        url = '/api/collaboration_invites/' + \
            str(json_obj['id'])+'/accept_collaboration_invite/'
        response = self.client.post(url,
                                    {'to_project': self.project.id},
                                    format='json')
        self.assertEqual(response.status_code, 201)

        response = self.client.get(
            '/api/collaboration_invites/',
            {'to_user__id': self.invited_user.id})
        self.assertEqual(response.content.decode('utf-8'), '[]')
