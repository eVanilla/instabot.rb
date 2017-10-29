module Config
	
	class << self
		attr_accessor :options
	end

	def self.setup
		self.options ||= Configuration.new
		yield(options)
	end

	class Configuration
		attr_accessor :username, :password, :tags, :comments, :pretty_print, :pre_load, :wait_per_action, :infinite_tags, :max_like_per_day, :max_follow_per_day, :max_unfollow_per_day, :max_comment_per_day, :unwanted_list, :white_list_users
		def initialize
			@username				= nil
			@password 				= nil
			@tags					= ["test","hello","hello_world","birthday","food"]
			@max_like_per_day 		= 10
			@max_follow_per_day 	= 10
			@max_unfollow_per_day	= 10
			@max_comment_per_day	= 10
			@unwanted_list 			= nil
			@comments 				= [	
										["this", "the", "your"],
										["photo", "picture", "pic", "shot", "snapshot"],
										["is", "looks", "feels", "is really"],
										["great", "super", "good", "very good", "good","wow", "WOW", "cool", "GREAT","magnificent","magical", "very cool", "stylish", "beautiful","so beautiful", "so stylish","so professional","lovely", "so lovely","very lovely", "glorious","so glorious","very glorious", "adorable", "excellent","amazing"], 
										[".", "..", "...", "!","!!","!!!"]
									]	
			@wait_per_action		= 1 * 60
			@white_list_users 		= nil
			@infinite_tags 			= false
			@pretty_print 			= true
			@pre_load 				= false
		end	
	end

end