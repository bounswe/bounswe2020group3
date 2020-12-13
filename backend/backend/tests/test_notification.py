from rest_framework.test import APITestCase
from django.contrib.auth.models import User
from api.models.project import Project
from notifications.signals import notify
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

        self.draft_project = Project.objects.create(
            name='Draft Project',
            description='I just started this project',
            state='draft',
            owner=self.owner, due_date="2020-12-31")

        self.draft_project2 = Project.objects.create(
            name='Draft Project',
            description='I just started this project',
            state='draft',
            owner=self.owner, due_date="2021-03-31")

        notify.send(sender=self.owner,
                    recipient=self.invited_user,
                    target=self.project,
                    verb="invited to Project called {}".format(self.project.name),
                    description="Invitation to Project")
        notify.send(sender=self.owner,
                    recipient=self.owner,
                    target=self.draft_project,
                    verb="created the new project called {}".format(self.draft_project.name),
                    description="New Project")

        notify.send(sender=self.owner,
                    recipient=self.owner,
                    target=self.draft_project2,
                    verb="created the new project called {}".format(self.draft_project2.name),
                    description="New Project")

    def test_can_get_own_notifications(self):
        self.client.force_authenticate(user=self.invited_user)
        response = self.client.get('/api/notifications/',
                                   format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.data[0]
        sender = data['actor']
        recipient = data['recipient']
        target = data['target']
        verb = data['verb']
        self.assertEqual(sender['username'], self.owner.username)
        self.assertEqual(recipient['username'], self.invited_user.username)
        self.assertEqual(target['state'], self.project.state)
        self.assertEqual(verb, "invited to Project called {}".format(self.project.name))

    def test_can_get_unread_notification(self):
        self.client.force_authenticate(user=self.owner)
        response = self.client.get('/api/notifications/unread/',
                                   format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 2)


