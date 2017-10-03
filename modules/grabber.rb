module Grabber


	




	def get_user_informations(user_id)
		puts "=".cyan*10
		user_page 	= "https://www.instagram.com/web/friendships/#{user_id}/follow/"
		@agent.get(user_page)
		last_page 	= @agent.history.last.uri.to_s
		username	= last_page.split('/')[3]
		user_info 	= @agent.get("https://instagram.com/#{username}/?__a=1")
		data1 = JSON.parse(user_info.body)
		data1.extend Hashie::Extensions::DeepFind

		# File.open("body.json", "w+") {|file| file.puts data1.extend Hashie::Extensions::DeepFind }

		@informations = {   
			followers: data1.deep_find("followed_by")["count"],
			following: data1.deep_find("follows")["count"],
			is_private: data1.deep_find("is_private"),
			is_verified: data1.deep_find("is_verified"),
			username: data1.deep_find("username"),
			full_name: data1.deep_find("full_name"),
			id: data1.deep_find("id")
		}
		puts @informations
	
	end















end