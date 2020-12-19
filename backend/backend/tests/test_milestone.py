from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase
from api.models.project import Project


class MilestoneTests(APITestCase):
    """
        Tests for the milestone model.
    """

    def setUp(self):
        self.user = User.objects.create_user(
            username='milestone_usr', email='milestone_user@gmail.com',
            password='1234_secret')
        self.client.force_authenticate(user=self.user)
        self.project = Project.objects.create(
            name='Academic Project',
            description='This is an academic project.',
            state='open for collaborators',
            owner=self.user, due_date="2020-12-25")
        self.project2 = Project.objects.create(
            name='ML Project',
            description='This is an ML project.',
            state='open for collaborators',
            owner=self.user, due_date="2020-12-30")

    def test_can_create_milestone(self):
        response = self.client.post('/api/milestones/',
                                    {"description": "Test",
                                     "date": "2020-12-25",
                                     "project": self.project.id},
                                    format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_can_get_milestone(self):
        self.client.post('/api/milestones/',
                         {"description": "Test",
                          "date": "2020-12-25",
                          "project": self.project.id},
                         format='json')

        response = self.client.get('/api/milestones/', format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 1)

    def test_can_get_all_own_milestones(self):
        self.client.post('/api/milestones/',
                         {"description": "Test",
                          "date": "2020-12-28",
                          "project": self.project.id},
                         format='json')
        self.client.post('/api/milestones/',
                         {"description": "Test",
                          "date": "2020-12-25",
                          "project": self.project2.id},
                         format='json')
        response = self.client.get('/api/milestones/get_user_milestones/',
                                   format='json')
        result = response.data['result']
        self.assertEqual(len(result), 2)
        self.assertEqual(result[0]['date'], '2020-12-25')

    def test_can_delete_milestone(self):
        response1 = self.client.post('/api/milestones/',
                                     {"description": "Test",
                                      "date": "2020-12-28",
                                      "project": self.project.id},
                                     format='json')

        delete_response = self.client.delete('/api/milestones/{}/'.
                                             format(response1.data['id']))
        self.assertEqual(delete_response.status_code,
                         status.HTTP_204_NO_CONTENT)
