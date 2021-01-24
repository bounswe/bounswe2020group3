from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase


class FeedTests(APITestCase):
    def setUp(self):
        # Admin id=1
        self.admin = User.objects.create_superuser(
            username='admin',
            password='admin',
        )
        # User 1 id=2
        self.user1 = User.objects.create_user(
            username='user1',
            password='user1',
        )
        # User 2 id=3
        self.user2 = User.objects.create_user(
            username='user2',
            password='user2',
        )
        # User 3 id=4
        self.user3 = User.objects.create_user(
            username='user3',
            password='user3',
        )

        # User 2 follows user 1
        self.client.force_authenticate(user=self.user2)
        self.client.post('/api/follow/', {
            "to_user": 2
        }, format='json')

        '''
            User 1 logins and create an new event,
            a new tag and a new project.
        '''

        self.client.force_authenticate(user=self.user1)

        self.client.post('/api/events/', {
            "title": "Conference on Computer Vision and Pattern Recognition",
            "description": "computer vision event",
            "deadline": "2021-01-30",
            "date": "2021-01-23",
            "event_type": "academic conference",
            "url": "http://cvpr2020.thecvf.com"
        }, format='json')

        self.client.post('/api/tags/', {
            "name": "ML",
            "color": 1000
        }, format='json')

        self.project = self.client.post('/api/projects/', {
            "name": "ML Project",
            "description": "project about ML",
            "requirements": "ML",
            "is_public": True,
            "state": "open for collaborators",
            "project_type": "conference",
            "due_date": "2021-01-30",
            "event": 1,
            "tags": [
                1
            ]
        })

    '''
        User 2 followed the User 1 and he/she should see
        user1's activities. Ex. Project
    '''

    def test_can_get_timeline(self):
        self.client.force_authenticate(user=self.user2)
        response = self.client.get('/api/feeds/timeline/', format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        result = response.data['results']
        for item in result:
            if item['type'] == 'project' and \
                    item['object'] == self.project.data['id']:
                project_name = item['project']['name']
                self.assertEqual(project_name, self.project.data['name'])

    '''
        User can see users in their timeline.
    '''

    def test_can_get_followers(self):
        self.client.force_authenticate(user=self.user2)
        response = self.client.get('/api/feeds/followers/', format='json')
        result = response.data['results'][0]
        self.assertEqual("timeline:" + str(self.user2.id), result['feed_id'])
        self.assertEqual("user:" + str(self.user1.id), result['target_id'])

    '''
        User 2 followed the User 1 but he/she doesn't
        want to see user1's activities.
    '''

    def test_can_unfollow_timeline(self):
        self.client.force_authenticate(user=self.user2)
        unfollow_response = self.client.post('/api/feeds/unfollow', {
            "user_id": 2
        }, format='json')
        self.assertEqual(unfollow_response.status_code,
                         status.HTTP_301_MOVED_PERMANENTLY)

        response = self.client.get('/api/feeds/timeline/', format='json')
        result = response.data['results']
        found_project = False
        for item in result:
            if item['type'] == 'project' and \
                    item['object'] == self.project.data['id']:
                found_project = True

        self.assertEqual(found_project, False)
