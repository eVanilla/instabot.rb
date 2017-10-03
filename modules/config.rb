module Config
	
	class << self
		attr_accessor :options
	end

	def self.setup
		self.options ||= Configuration.new
		yield(options)
	end

	class Configuration
		attr_accessor :username, :password, :max_likes_per_day, :max_follow_per_day, :max_comments_per_day, :unwanted_list, :white_list_users

		def initialize
			@username,
			@password,
			@max_likes_per_day,
			@max_follow_per_day,
			@max_comments_per_day,
			@unwanted_list,
			@white_list_users = nil



			
		end
	end

end