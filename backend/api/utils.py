from api.models.following import Following, FollowRequest
from api.models.project import Project


def get_is_following(this_user, accessed_user):
    '''
        Returns True if "this_user" follows "accessed_user"
    '''
    if not this_user or this_user.is_anonymous:
        is_following = False
    else:
        is_following = \
            Following.objects. \
                filter(from_user=this_user,
                       to_user=accessed_user).exists()
    return is_following


def get_is_follower(this_user, accessed_user):
    '''
        Returns True if "accessed_user" follows "this_user"
    '''
    if not this_user or this_user.is_anonymous:
        is_follower = False
    else:
        is_follower = \
            Following.objects. \
                filter(from_user=accessed_user,
                       to_user=this_user).exists()
    return is_follower


def get_is_follow_request_sent(this_user, accessed_user):
    '''
        Returns True if "this_user" has sent follow request to "accessed_user"
    '''
    if not this_user or this_user.is_anonymous:
        is_is_follow_request_sent = False
    else:
        is_is_follow_request_sent = \
            FollowRequest.objects. \
                filter(req_from_user=this_user,
                       req_to_user=accessed_user).exists()
    return is_is_follow_request_sent


def get_is_follow_request_received(this_user, accessed_user):
    '''
        Returns True if "this_user" has gotten follow request from "accessed_user"
    '''
    if not this_user or this_user.is_anonymous:
        is_is_follow_request_received = False
    else:
        is_is_follow_request_received = \
            FollowRequest.objects. \
                filter(req_from_user=accessed_user,
                       req_to_user=this_user).exists()
    return is_is_follow_request_received


def get_is_collaborator(this_user, accessed_user):
    '''
    Returns True if "this_user" and "accessed_user" has a project that
    they are both a member.
    '''
    if not this_user or this_user.is_anonymous:
        is_collaborator = False
    else:
        common = Project.objects. \
            filter(members__exact=this_user.id)
        is_collaborator = common. \
            filter(members__exact=accessed_user.id).exists()

    return is_collaborator


def get_count_of_followers(this_user):
    """
        Returns length of followers of user
    """
    return Following.objects.filter(to_user=this_user.id).count()


def get_count_of_followings(this_user):
    """
        Returns length of followings of user
    """
    return Following.objects.filter(from_user=this_user.id).count()


def get_count_of_follow_requests(this_user):
    """
        Returns length of follow requests coming to user.
    """
    return FollowRequest.objects.filter(req_to_user=this_user.id).count()
