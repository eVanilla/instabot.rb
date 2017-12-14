module Actions
  def follow(user_id)
    log("trying to follow a user [#{user_id}]", 'ACTIONS')
    check_login_status
    url = "https://www.instagram.com/web/friendships/#{user_id}/follow/"
    set_mechanic_data
    response = @agent.post(url, @params, @headers)
    save_action_log user_id, :follow
    @local_stroage[:followed_users] << user_id
    { user_id: user_id, response_code: response.code }
  end

  def unfollow(user_id)
    log("trying to unfollow a user [#{user_id}]", 'ACTIONS')
    check_login_status
    url = "https://www.instagram.com/web/friendships/#{user_id}/unfollow/"
    set_mechanic_data
    response = @agent.post(url, @params, @headers)
    save_action_log user_id, :unfollow
    @local_stroage[:unfollowed_users] << user_id
    { user_id: user_id, response_code: response.code }
  end

  def like(media_id)
    log("trying to like a media[#{media_id}]", 'ACTIONS')
    check_login_status
    url = "https://www.instagram.com/web/likes/#{media_id}/like/"
    set_mechanic_data
    response = @agent.post(url, @params, @headers)
    save_action_log media_id, :like
    @local_stroage[:liked_medias] << media_id
    { media_id: media_id, response_code: response.code }
  end

  def unlike(media_id)
    log("trying to unlike a media[#{media_id}]", 'ACTIONS')
    check_login_status
    url = "https://www.instagram.com/web/likes/#{media_id}/unlike/"
    set_mechanic_data
    response = @agent.post(url, @params, @headers)
    save_action_log media_id, :unlike
    @local_stroage[:unliked_medias] << media_id
    { media_id: media_id, response_code: response.code }
  end

  def comment(media_id, text = '')
    log("trying to send a comment to media[#{media_id}]", 'ACTIONS')
    check_login_status
    url = "https://www.instagram.com/web/comments/#{media_id}/add/"
    set_mechanic_data(comment_text: text.to_s)
    response = @agent.post(url, @params, @headers)
    save_action_log media_id, :comment
    @local_stroage[:commented_medias] << media_id
    { media_id: media_id, response_code: response.code }
  end
end
