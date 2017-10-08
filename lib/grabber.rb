module Grabber


	




	def get_user_informations(user_id)
		puts "=".cyan*10
		user_page 	= "https://www.instagram.com/web/friendships/#{user_id}/follow/"
		@agent.get(user_page)
		last_page 	= @agent.history.last.uri.to_s
		username	= last_page.split('/')[3]
		user_info 	= @agent.get("https://instagram.com/#{username}/?__a=1")
		data = JSON.parse(user_info.body)
		data.extend Hashie::Extensions::DeepFind

		# File.open("body.json", "w+") {|file| file.puts data.extend Hashie::Extensions::DeepFind }

		@informations = {   
			followers: data.deep_find("followed_by")["count"],
			following: data.deep_find("follows")["count"],
			is_private: data.deep_find("is_private"),
			is_verified: data.deep_find("is_verified"),
			username: data.deep_find("username"),
			full_name: data.deep_find("full_name"),
			id: data.deep_find("id")
		}
		puts @informations
	
	end

	def get_media_informations(media_id)
		puts "=".cyan*10
		puts "trying to get media (#{media_id}) information"
		media_info 	= @agent.get("https://www.instagram.com/p/#{media_id}/?__a=1")
		data 		= JSON.parse(media_info.body)
		data.extend Hashie::Extensions::DeepFind

		# puts data.deep_find('id')
		# puts data.deep_find('is_video')
		# puts data.deep_find('comments_disabled')
		# puts data.deep_find('viewer_has_liked')
		# puts data.deep_find('has_blocked_viewer')
		# puts data.deep_find('followed_by_viewer')
		# puts data.deep_find('full_name')
		# puts data.deep_find('is_private')
		# puts data.deep_find('is_verified')
		# puts data.deep_find('requested_by_viewer')

		@informations = {   
			id: data.deep_find("id"),
			is_video: data.deep_find("is_video"),
			comments_disabled: data.deep_find("comments_disabled"),
			viewer_has_liked: data.deep_find("viewer_has_liked"),
			has_blocked_viewer: data.deep_find("has_blocked_viewer"),
			followed_by_viewer: data.deep_find("followed_by_viewer"),
			full_name: data.deep_find("full_name"),
			is_private: data.deep_find("is_private"),
			is_verified: data.deep_find("is_verified"),
			requested_by_viewer: data.deep_find("requested_by_viewer")
		}
		puts @informations


	end



	def search(tags=[])
		tags.each do |tag|
			url 		= "https://www.instagram.com/explore/tags/#{tag}/?__a=1"
			response 	= @agent.get(url)
			puts response.body.to_s.cyan[0..50]
			data = JSON.parse(response.body)
			data.extend Hashie::Extensions::DeepFind
			owners = data.deep_find_all("owner")
			media_codes = data.deep_find_all("code")
			owners.map { |id| users << id['id']}	
			media_codes.map {|code| medias << code}
		end
	end	










end