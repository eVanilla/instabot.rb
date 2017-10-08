module Modes

	def mode(mode=:default)
		case mode
		when :auto
			puts "in auto mode".yellow
			search(options[:tags])
			while true
				unless @maximums[:max_likes_per_day] == @maximums[:likes_in_day] && @maximums[:max_follows_per_day] == @maximums[:follows_in_day] && @maximums[:max_unfollows_per_day] == @maximums[:unfollows_in_day] && @maximums[:max_comments_per_day]== @maximums[:comments_in_day]
					

					if @maximums[:follows_in_day] != @maximums[:max_follows_per_day]
						auto_follow 
					else
						puts "maximum follows per day!"
					end

					# if @maximums[:unfollows_in_day] != @maximums[:max_unfollows_per_day]
					# 	auto_unfollow
					# else
					# 	puts "maximum unfollows per day!"
					# end

					if @maximums[:likes_in_day] != @maximums[:max_likes_per_day]
						auto_like
					else
						puts "maximum likes per day!"
					end

					if @maximums[:comments_in_day] != @maximums[:max_comments_per_day]
						auto_comment
					else
						puts "maximum comments per day!"
					end
					
					# exit

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

	# def auto_unfollow
	# 	# users.each do |user|
	# 	all_users 	= users
	# 	puts "all users = #{all_users}"
	# 	id 			= 0
	# 	while @maximums[:unfollows_in_day] < @maximums[:max_unfollows_per_day]
	# 		get_user_informations(all_users[id])
	# 		puts "user informations:".cyan
	# 		@informations.map {|key,val| puts "#{key}: #{val}"}
	# 		unfollow(@informations[:id])
	# 		@maximums[:unfollows_in_day] += 1
	# 		id += 1
	# 		puts "unfollows_in_day = #{@maximums[:unfollows_in_day]} || max_unfollows_per_day = #{@maximums[:max_unfollows_per_day]} || id = #{id}"
	# 		fall_in_asleep
	# 	end
	# 	# end
	# end

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

	def fall_in_asleep
		time = options[:wait_per_action]
		puts "waiting for #{time}"
		sleep time
	end


end
