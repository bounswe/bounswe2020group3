from api.models.following import Following


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
