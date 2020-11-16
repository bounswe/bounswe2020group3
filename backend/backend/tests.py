from rest_framework.test import APITestCase


class IndexTestCase(APITestCase):
    def test_index_page(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)
