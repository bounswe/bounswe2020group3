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
        return request.user in obj.members.all() \
            or request.user == obj.owner


class IsRequestSenderOrReceiver(permissions.BasePermission):
    """
    Custom permission to only allow users to send request.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return request.user.id == obj.req_from_user.id \
                or request.user.id == obj.req_to_user.id

        # Write permissions are only allowed to the members of the snippet.
        return request.user.id == obj.req_from_user


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


class IsFileMember(permissions.BasePermission):
    """
    Custom permission to only allow members of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        safe_method = request.method in permissions.SAFE_METHODS
        public = obj.project.is_public

        if safe_method and public:
            return True

        # Write permissions are only allowed to the members of the project.
        return request.user in obj.project.members.all() or \
            request.user == obj.project.owner


class CollaborationPermissions(permissions.BasePermission):
    """
    Custom permission to only allow members of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        if view.action in ['retrieve', 'list']:
            return request.user == obj.to_user or \
                request.user == obj.from_user
        elif view.action in ['update', 'partial_update', 'destroy']:
            return request.user == obj.from_user
        return True


class ProfileDeletion(permissions.BasePermission):
    """
    Custom permission to only allow members of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        if view.action in ['destroy']:
            if request.user.is_staff:
                return True
            else:
                return False

        return True


class CommentPermission(permissions.BasePermission):
    """
    Custom permission to only allow owner of a comment edit it.
    Commented user can also delete the comment.
    """

    def has_object_permission(self, request, view, obj):
        if view.action in ['destroy', 'update', 'partial_update']:
            return request.user == obj.from_user

        return True


class RatingPermission(permissions.BasePermission):
    """
    Custom permission to only allow owner of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        return request.user == obj.from_user
