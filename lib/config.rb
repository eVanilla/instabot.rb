module Config
	
	class << self
		attr_accessor :options
	end

	def self.setup
		self.options ||= Configuration.new
		yield(options)
	end

	class Configuration
		attr_accessor :username, :password, :tags, :comments, :wait_per_action, :max_like_per_day, :max_follow_per_day, :max_unfollow_per_day, :max_comment_per_day, :unwanted_list, :white_list_users
		def initialize
			@username,
			@password,
			@tags,
			@max_like_per_day,
			@max_follow_per_day,
			@max_unfollow_per_day,
			@max_comment_per_day,
			@unwanted_list,
			@comments,
			@wait_per_action,
			@white_list_users = nil
		end	
	end

end