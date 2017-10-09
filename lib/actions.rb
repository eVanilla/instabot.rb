module Actions
	
	def follow(user_id)
		puts "trying to follow a user [#{user_id}]"
		log("trying to follow a user [#{user_id}]")
		check_login_status
		follow_url = "https://www.instagram.com/web/friendships/#{user_id}/follow/"
		set_mechanic_data
		followed_page = @agent.post(follow_url, @params, @headers)
		puts "User followed!".bold.cyan
		save_action_data user_id, :follow
		@local_stroage[:followed_users] << user_id
	end

	def unfollow(user_id)
		puts "trying to unfollow a user [#{user_id}]"	
		log("trying to unfollow a user [#{user_id}]")
		check_login_status
		unfollow_url = "https://www.instagram.com/web/friendships/#{user_id}/unfollow/"
		set_mechanic_data
		followed_page = @agent.post(unfollow_url, @params, @headers)
		puts "user unfollowed!".bold.cyan
		save_action_data user_id, :unfollow
		@local_stroage[:unfollowed_users] << user_id
	end

	def like(media_id)
		puts "trying to like a media[#{media_id}]"	
		log("trying to like a media[#{media_id}]")
		check_login_status
		comment_url = "https://www.instagram.com/web/likes/#{media_id}/like/"
		set_mechanic_data
		followed_page = @agent.post(comment_url, @params, @headers)
		puts "media liked!".bold.cyan
		save_action_data media_id, :like
		@local_stroage[:liked_medias] << media_id
	end

	def comment(media_id=0, text="")
		puts "trying to send a comment to media[#{media_id}]"	
		log("trying to send a comment to media[#{media_id}]")
		check_login_status
		comment_url = "https://www.instagram.com/web/comments/#{media_id}/add/"
		set_mechanic_data({ comment_text: text.to_s })
		followed_page = @agent.post(comment_url, @params, @headers)
		puts "comment successfully has been sent!".bold.cyan
		save_action_data media_id, :comment
		@local_stroage[:commented_medias] << media_id
	end

end
