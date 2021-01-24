from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase
from api.models.project import Project
from api.models.profile import Profile


class CollaboratorRecommendationTests(APITestCase):
    """
    Tests for the collaborators.
    """

    def setUp(self):
        self.owner = User.objects.create_user(
            username='jane_doe', email='jane_doe@…', password='1234_secret')
        self.expected_user = User.objects.create_user(
            username='mehmet', email='mehmet@…', password='1234_secret')
        self.expected_profile = Profile.objects.create(
            expertise='Machine Learning', owner=self.expected_user)
        self.unexpected_user = User.objects.create_user(
            username='mahmut', email='mahmut@…', password='1234_secret')
        self.unexpected_profile = Profile.objects.create(
            expertise='Psychology', owner=self.unexpected_user)
        self.project = Project.objects.create(
            name='Academic Project',
            description='This is an academic project.',
            requirements='Machine Learning, NLP',
            state='open for collaborators',
            owner=self.owner, due_date="2020-12-15")

    def test_can_get_recommendation(self):
        self.client.force_authenticate(user=self.owner)
        response = self.client.get('/api/users/' +
                                   'get_collaborator_recommendation/' +
                                   '?project_id=1')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
