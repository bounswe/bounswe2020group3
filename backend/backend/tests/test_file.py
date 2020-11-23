from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase
# from django.core.files.uploadedfile import SimpleUploadedFile


class FileTests(APITestCase):
    """
    Tests for the file model.
    """
    def setUp(self):
        self.username = 'john_doe'
        self.password = 'foobar'
        self.user = User.objects.create(username=self.username,
                                        password=self.password)
        self.client.force_authenticate(user=self.user)

    def test_can_read_file_list(self):
        response = self.client.get('/api/files/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_can_create_and_retrieve_file(self):
        user_id = self.user.id
        user_url = f"http://127.0.0.1:8000/api/users/{user_id}/"
        project_response = self.client.post('/api/projects/',
                                            {"name": "aaa",
                                             "members": [user_url],
                                             },
                                            format='json')
        project_id = project_response.data["id"]
        project_url = f"http://127.0.0.1:8000/api/projects/{project_id}/"
        # Another way of getting a file, without having a file.
        # test_file = SimpleUploadedFile("test_file.txt",
        #                                b"file_content",
        #                                content_type="text/txt")
        with open('backend/tests/test_media/test_file.txt') as test_file:
            response = self.client.post('/api/files/',
                                        {'file': test_file,
                                         'remark': 'test_file',
                                         'project': project_url},
                                        format='multipart')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        file_id = response.data["id"]
        # file_url = f"http://127.0.0.1:8000/api/files/{file_id}/"
        r_response = self.client.get(f'/api/files/{file_id}/retrieve_file/')
        self.assertEqual(r_response.status_code, status.HTTP_200_OK)
