from rest_framework import generics, mixins


class ExampleGenericAPIView(generics.GenericAPIView,
                            mixins.ListModelMixin,
                            mixins.CreateModelMixin, ):
    def get(self, request):
        return self.list(request)

    def post(self, request):
        return self.create(request)


class ExampleDetailGenericAPIView(generics.GenericAPIView,
                                  mixins.RetrieveModelMixin,
                                  mixins.UpdateModelMixin,
                                  mixins.DestroyModelMixin):

    def get(self, request, id=None):
        return self.retrieve(request, id)

    def put(self, request, id=None):
        return self.update(request, id)

    def delete(self, request, id):
        return self.destroy(request, id)
