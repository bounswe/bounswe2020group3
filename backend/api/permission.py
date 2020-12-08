from rest_framework import permissions


class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Custom permission to only allow owners of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the owner of the snippet.
        return obj.owner == request.user


class IsMemberOrReadOnly(permissions.BasePermission):
    """
    Custom permission to only allow members of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the members of the snippet.
        return request.user in obj.members.all() or request.user == obj.owner


class IsMilestoneMemberOrReadOnly(permissions.BasePermission):
    """
    Custom permission to only allow members of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the members of the project.
        return request.user in obj.project.members.all() or \
            request.user == obj.project.owner


class IsFileMemberOrReadOnly(permissions.BasePermission):
    """
    Custom permission to only allow members of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        c1 = request.method in permissions.SAFE_METHODS
        c2 = obj.project.is_public

        if c1 and c2:
            return True

        # Write permissions are only allowed to the members of the project.
        return request.user in obj.project.members.all() or \
            request.user == obj.project.owner


class CollaborationRequestPermissions(permissions.BasePermission):
    """
    Custom permission to only allow members of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        if view.action == 'create':
            return obj.to_project.state == "open for collaborators"
        elif view.action in ['retrieve', 'list']:
            return request.user == obj.to_user or request.user == obj.from_user
        elif view.action in ['update', 'partial_update', 'destroy']:
            return request.user == obj.from_user
        return True


class CollaborationInvitePermissions(permissions.BasePermission):
    """
    Custom permission to only allow members of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        if view.action in ['retrieve', 'list']:
            return request.user == obj.to_user or request.user == obj.from_user
        elif view.action in ['update', 'partial_update', 'destroy']:
            return request.user == obj.from_user
        return True
