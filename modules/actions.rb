module Actions
	
	def follow(user_id)
		check_login_status
		follow_url = "https://www.instagram.com/web/friendships/#{user_id}/follow/"
		set_mechanic_data
		followed_page = @agent.post(follow_url, @params, @headers)
		puts "User followed!".bold.cyan
	end

	def unfollow(user_id)
		check_login_status
		unfollow_url = "https://www.instagram.com/web/friendships/#{user_id}/unfollow/"
		set_mechanic_data
		followed_page = @agent.post(unfollow_url, @params, @headers)
		puts "user unfollowed!".bold.cyan
	end

	def comment(media_id=0, text="")
		check_login_status
		comment_url = "https://www.instagram.com/web/comments/#{media_id}/add/"
		set_mechanic_data { comment_text: text.to_s }
		followed_page = @agent.post(comment_url, @params, @headers)
		puts "comment successfully has been sent!".bold.cyan
	end

	def like(media_id)
		check_login_status
		comment_url = "https://www.instagram.com/web/likes/#{media_id}/like/"
		set_mechanic_data
		followed_page = @agent.post(comment_url, @params, @headers)
		puts "comment successfully has been sent!".bold.cyan
	end


end
