from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from api.models.project import Project


class ProfileTests(APITestCase):
    """
        Tests for the profile model.
    """

    def setUp(self):
        self.user = User.objects.create_user(
            username='jane_doe', email='jane_doe@…', password='1234_secret')
        self.client.force_authenticate(user=self.user)
        self.member_user = User.objects.create_user(
            username='mehmet', email='mehmet@…', password='1234_secret')
        self.project = Project.objects.create(
            name='Academic Project', description='This is an academic project.',
            owner=self.user, due_date="2020-12-15")
        self.project.members.add(self.member_user)

    def test_can_create_milestone(self):
        data = {'description': 'The pre-proposal milestone for the project.',
                'due_date': '2020-11-15',
                'project': 'https://paperlayer.herokuapp.com/api/milestones/1'}
        response = self.client.get('/api/milestones/', data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_can_read_milestones(self):
        response = self.client.get('/api/milestones/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
