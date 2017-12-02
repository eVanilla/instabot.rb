module Actions
	
	def follow(user_id)
		log("trying to follow a user [#{user_id}]", "ACTIONS")
		check_login_status()
		follow_url = "https://www.instagram.com/web/friendships/#{user_id}/follow/"
		set_mechanic_data
		response = @agent.post(follow_url, @params, @headers)
		# custom_puts "User followed!".bold.cyan
		save_action_data user_id, :follow
		@local_stroage[:followed_users] << user_id
		return({user_id: user_id, response_code: response.code})
	end

	def unfollow(user_id)
		log("trying to unfollow a user [#{user_id}]", "ACTIONS")
		check_login_status()
		unfollow_url = "https://www.instagram.com/web/friendships/#{user_id}/unfollow/"
		set_mechanic_data
		response = @agent.post(unfollow_url, @params, @headers)
		# custom_puts "[+] ".cyan + "User unfollowed!".bold.cyan
		save_action_data user_id, :unfollow
		@local_stroage[:unfollowed_users] << user_id
		return({user_id: user_id, response_code: response.code})
	end

	def like(media_id)
		log("trying to like a media[#{media_id}]", "ACTIONS")
		check_login_status()
		comment_url = "https://www.instagram.com/web/likes/#{media_id}/like/"
		set_mechanic_data
		response = @agent.post(comment_url, @params, @headers)
		# custom_puts "[+] ".cyan + "Media liked".bold.cyan
		save_action_data media_id, :like
		@local_stroage[:liked_medias] << media_id
		return({media_id: media_id, response_code: response.code})
	end

	def comment(media_id, text="")
		log("trying to send a comment to media[#{media_id}]", "ACTIONS")
		check_login_status()
		comment_url = "https://www.instagram.com/web/comments/#{media_id}/add/"
		set_mechanic_data({ comment_text: text.to_s })
		response = @agent.post(comment_url, @params, @headers)
		# custom_puts "[+] ".cyan + "comment successfully has been sent".bold.cyan
		save_action_data media_id, :comment
		@local_stroage[:commented_medias] << media_id
		return({media_id: media_id, response_code: response.code})
	end

end
