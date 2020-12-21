from rest_framework.test import APITestCase
from django.contrib.auth.models import User
from api.models.project import Project
from rest_framework import status


class NotificationTests(APITestCase):
    def setUp(self):
        self.owner = User.objects.create_user(
            username="casi",
            email="test@gmail.com",
            password="qwerty123"
        )
        self.invited_user = User.objects.create_user(
            username="ahmet",
            email="ahmet@gmail.com",
            password="qwerty123"
        )
        self.project = Project.objects.create(
            name='Academic Project',
            description='This is an academic project.',
            state='open for collaborators',
            owner=self.owner, due_date="2020-12-31")

        self.client.force_authenticate(user=self.owner)

        self.client.post('/api/collaboration_invites/', {
                "to_user": self.invited_user.id,
                "to_project": self.project.id,
                "message": "Come and join our project"
            }, format='json')

    def test_can_get_own_notifications(self):
        self.client.force_authenticate(user=self.invited_user)
        response = self.client.get('/api/notifications/',
                                   format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.data['result'][0]
        sender = data['actor']
        recipient = data['recipient']
        verb = data['verb']
        self.assertEqual(sender['username'], self.owner.username)
        self.assertEqual(recipient['username'], self.invited_user.username)
        self.assertEqual(verb, "invited you to the Project {}".
                         format(self.project.name))