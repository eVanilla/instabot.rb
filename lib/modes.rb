module Modes

	def mode(mode=:default)
		case mode
		when :auto
			puts "in auto mode".yellow
			search(options[:tags])
			@next_day = Time.new + 10.second

			while true
				# if @maximums[:likes_in_day] != @maximums[:max_likes_per_day] && @maximums[:follows_in_day] != @maximums[:max_follows_per_day] && @maximums[:unfollows_in_day] != @maximums[:max_unfollows_per_day] &&  @maximums[:comments_in_day] != @maximums[:max_comments_per_day]	
				if !maximums_are_full?
					puts "in actions ...".red
					if @maximums[:follows_in_day] != @maximums[:max_follows_per_day]
						@maximums[:follows_in_day] += 1
						# auto_follow 
					else
						puts "maximum follows per day!"
					end

					if @maximums[:unfollows_in_day] != @maximums[:max_unfollows_per_day]
						@maximums[:unfollows_in_day] += 1
						# auto_unfollow
					else
						puts "maximum unfollows per day!"
					end

					if @maximums[:likes_in_day] != @maximums[:max_likes_per_day]
						@maximums[:likes_in_day] += 1
						# auto_like
					else
						puts "maximum likes per day!"
					end

					if @maximums[:comments_in_day] != @maximums[:max_comments_per_day]
						@maximums[:comments_in_day] += 1
						# auto_comment
					else
						puts "maximum comments per day!"
					end
					puts "maximums = #{@maximums}"
					
					# exit
				else
					puts "in check date ... "
					check_date
					sleep 1
				end
			end
		when :cleanup
			puts "in clean up"
			# users.each do |user|
			# 	get_user_informations(user)
			# 	unfollow(@informations[:id])
			# end
		when :default
			puts "please choose a mode"
			# => ...
		end
	end










	def auto_follow
		all_users 	= users
		id 			= 0
		puts "all users = #{all_users}"
		# users.each do |user| 
		while @maximums[:follows_in_day] < @maximums[:max_follows_per_day]
			get_user_informations(all_users[id])
			puts "user informations:".cyan
			@informations.map {|key,val| puts "#{key}: #{val}"}
			follow(@informations[:id])
			@maximums[:follows_in_day] += 1
			id += 1
			puts "development informations: ".cyan
			puts "follows_in_day = #{@maximums[:follows_in_day]} || max_follows_per_day = #{@maximums[:max_follows_per_day]} || id = #{id}"
			fall_in_asleep
		end
		# end
	end

	def auto_unfollow
		# users.each do |user|
		unfollowed_users = @local_stroage[:unfollowed_users]
		puts "all unfollowed users = #{unfollowed_users}"
		id 			= 0
		while @maximums[:unfollows_in_day] < @maximums[:max_unfollows_per_day]
			if @local_stroage[:followed_users].size < @maximums[:max_unfollows_per_day]
				# get_user_informations(unfollowed_users[id])
				# puts "user informations:".cyan
				# @informations.map {|key,val| puts "#{key}: #{val}"}
				puts "unfollowed_users[id] => #{unfollowed_users[id]}"
				unfollow(unfollowed_users[id])
				@maximums[:unfollows_in_day] += 1
				id += 1
				puts "unfollows_in_day = #{@maximums[:unfollows_in_day]} || max_unfollows_per_day = #{@maximums[:max_unfollows_per_day]} || id = #{id}"
				fall_in_asleep
			else
				puts "bla bla bla"
				break
			end
		end
	end

	def auto_like
		# medias.each do |media|
		all_medias 	= medias
		puts "all medias = #{all_medias}"
		id 			= 0
		while @maximums[:likes_in_day] < @maximums[:max_likes_per_day]
			get_media_informations(all_medias[id])
			puts "media informations:".cyan
			@informations.map {|key,val| puts "#{key}: #{val}"}
			like(@informations[:id])
			@maximums[:likes_in_day] += 1
			puts "likes_in_day = #{@maximums[:likes_in_day]} || max_likes_per_day = #{@maximums[:max_likes_per_day]}"
			fall_in_asleep
		end
	end

	def auto_comment
		# medias.each do |media|
		all_medias 	= medias
		puts "all medias = #{all_medias}"
		id 			= 0
		while @maximums[:comments_in_day] < @maximums[:max_comments_per_day]
			get_media_informations(all_medias[id])
			puts "media informations:".cyan
			@informations.map {|key,val| puts "#{key}: #{val}"}
			comment(@informations[:id], generate_a_comment)
			@maximums[:comments_in_day] += 1
			puts "comments_in_day = #{@maximums[:comments_in_day]} || max_comments_per_day = #{@maximums[:max_comments_per_day]}"
			fall_in_asleep
		end
	end
	
	def generate_a_comment
		comments 	= options[:comments]
		first 		= comments[0].sample
		second 		= comments[1].sample
		third 		= comments[2].sample
		fourth		= comments[3].sample
		fifth 		= comments[4].sample
		return "#{first} #{second} #{third} #{fourth}#{fifth}"
	end

	def check_date
		puts "checking time ..."
		time = ((@next_day) - Time.new).to_i # => seconds elapsed ...
		puts "next day = #{@next_day}"
		if time == 0
			puts "its a new day!"
			@local_stroage[:followed_users] 	= []
			@local_stroage[:unfollowed_users] 	= []
			@local_stroage[:liked_medias] 		= []
			@local_stroage[:commented_medias] 	= []
			@maximums[:follows_in_day] 		= 0 
			@maximums[:unfollows_in_day] 	= 0
			@maximums[:likes_in_day] 		= 0
			@maximums[:comments_in_day] 	= 0
			# time = (((Time.new + 1.days).to_f - Time.new.to_f) * 24 * 60 * 60).to_i
			@next_day = Time.new + 1.days
			puts "new next day = #{@next_day}"
			puts "new maximums = #{@maximums}"
			puts "new local stroage = #{@local_stroage}"
			puts "="*10
		else
			puts "#{time} seconds elapsed..."
		end 
			# return true
	end

	def fall_in_asleep
		time = options[:wait_per_action]
		puts "waiting for #{time}"
		sleep time
	end

	def maximums_are_full?
		if @maximums[:likes_in_day] == @maximums[:max_likes_per_day] && @maximums[:follows_in_day] == @maximums[:max_follows_per_day] && @maximums[:unfollows_in_day] == @maximums[:max_unfollows_per_day] && @maximums[:comments_in_day] == @maximums[:max_comments_per_day]
			return true
		else
			return false
		end
	end







end