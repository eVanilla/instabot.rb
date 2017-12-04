module Config

	class << self
		attr_accessor :options
	end

	def self.setup
		self.options ||= Configuration.new
		yield(options)
	end

	class Configuration
		attr_accessor 	:username, :password, :tags, :use_proxy, :proxy, :comments,
							:print_banner, :pre_load, :wait_per_action, :infinite_tags,
							:max_like_per_day, :max_follow_per_day, :max_unfollow_per_day,
							:max_comment_per_day, :unwanted_list, :white_list_users
		def initialize
			@infinite_tags        = true
			@max_comment_per_day  = 50
			@max_follow_per_day   = 50
			@max_like_per_day     = 50
			@max_unfollow_per_day = 50
			@password             = nil
			@pre_load             = true
			@print_banner         = true
			@proxy                = []
			@tags                 = %w[test hello hello_world birthday food]
			@unwanted_list        = nil
			@use_proxy            = false
			@username             = nil
			@wait_per_action      = 1 * 60
			@white_list_users     = nil
			@comments             = [
			%w[this the your],
			%w[photo picture pic shot snapshot],
			['is', 'looks', 'feels', 'is really'],
			['great', 'super', 'good', 'very good', 'good', 'wow', 'WOW', 'cool', 'GREAT', 'magnificent', 'magical', 'very cool', 'stylish', 'beautiful', 'so beautiful', 'so stylish', 'so professional', 'lovely', 'so lovely', 'very lovely', 'glorious', 'so glorious', 'very glorious', 'adorable', 'excellent', 'amazing'],
			['.', '..', '...', '!', '!!', '!!!']
			]
		end
	end
	
end
