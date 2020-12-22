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
            state='open for collaborators',
            owner=self.owner, due_date="2020-12-15")
        self.draft_project = Project.objects.create(
            name='Draft Project',
            description='I just started this project',
            state='draft',
            owner=self.owner, due_date="2020-12-15")

    def test_can_create_collaboration_invite(self):
        self.client.force_authenticate(user=self.owner)
        response = self.client.post('/api/collaboration_invites/',
                                    {'to_project': self.project.id,
                                     'to_user': self.invited_user.id},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
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
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        response = self.client.get(
            '/api/collaboration_invites/',
            {'to_user__id': self.invited_user.id})
        self.assertEqual(response.content.decode('utf-8'), '[]')

    def test_can_delete_collaboration_invite(self):
        self.client.force_authenticate(user=self.owner)
        response = self.client.post('/api/collaboration_invites/',
                                    {'to_project': self.project.id,
                                     'to_user': self.invited_user.id},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.client.force_authenticate(user=self.invited_user)
        response = self.client.get(
            '/api/collaboration_invites/',
            {'to_user__id': self.invited_user.id})
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertNotEqual(response.content.decode('utf-8'), '[]')
        self.client.force_authenticate(user=self.owner)
        response = self.client.delete(
            '/api/collaboration_invites/1/')
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        self.client.force_authenticate(user=self.invited_user)
        response = self.client.get(
            '/api/collaboration_invites/',
            {'to_user__id': self.invited_user.id})
        self.assertEqual(response.content.decode('utf-8'), '[]')

    def test_can_not_invite_self(self):
        self.client.force_authenticate(user=self.owner)
        response = self.client.post('/api/collaboration_invites/',
                                    {'to_project': self.project.id,
                                     'to_user': self.owner.id},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_can_not_invite_to_draft(self):
        self.client.force_authenticate(user=self.owner)
        response = self.client.post('/api/collaboration_invites/',
                                    {'to_project': self.draft_project.id,
                                     'to_user': self.invited_user.id},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
