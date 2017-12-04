module Modes
  def mode(mode = :default)
    case mode
    when :infinite
      puts '[+] '.cyan + '[Auto] mode is turned on'.yellow
      log('[Auto] mode is turned on', 'MODES')
      search(options[:tags])
      @tomorrow = Time.new + 1.days
      loop do
        if !maximums_are_full?
          if !follows_in_day_are_full?
            @maximums[:follows_in_day] += 1
            auto_follow
          else
            puts '[+] '.cyan + 'Maximum follows per day'.upcase
            log('Maximum follows per day', 'MODES')
          end

          if !unfollows_in_day_are_full?
            @maximums[:unfollows_in_day] += 1
            auto_unfollow
          else
            puts '[+] '.cyan + 'Maximum unfollows per day'.upcase
            log('Maximum unfollows per day', 'MODES')
          end

          if !likes_in_day_are_full?
            @maximums[:likes_in_day] += 1
            auto_like
          else
            puts '[+] '.cyan + 'Maximum likes per day'.upcase
            log('Maximum likes per day', 'MODES')
          end

          if !comments_in_day_are_full?
            @maximums[:comments_in_day] += 1
            auto_comment
          else
            puts '[+] '.cyan + 'Maximum comments per day'.upcase
            log('Maximum comments per day', 'MODES')
          end
        else
          check_date
          sleep 1
        end
      end
    when :clean_up
      puts '[+] '.cyan + '[Clean up] mode is turned on'.upcase.yellow
      log('[Clean up] mode is turned on', 'MODES')
      @local_stroage[:followed_users].each do |user|
        unfollow(user)
      end
    when :default
      puts '[-] '.cyan + 'Please choose a mode'.upcase.red
    else
      puts '[-] '.cyan + 'Please choose a mode'.upcase.red
    end
  end

  def auto_follow
    all_users 	 = users
    id 			      = 0
    puts '[+] '.cyan + "#{all_users.size} user is ready to follow".upcase
    while @maximums[:follows_in_day] < @maximums[:max_follows_per_day]
      begin
        id += 1 if all_users[id].nil? || all_users[id] == []
        get_user_informations(all_users[id])
        puts '[+] '.cyan + "Trying to follow user [#{all_users[id]}]"
        follow(@informations[:id])
        puts '[+] '.cyan + 'User followed'.upcase.green.bold
        @maximums[:follows_in_day] += 1
        id                         += 1
        fall_in_asleep
      rescue Exception => e
        puts "an error detected ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\nignored"
        id += 1
        retry
      end
    end
  end

  def auto_unfollow
    followed_users = @local_stroage[:followed_users]
    puts '[+] '.cyan + "#{followed_users.size} user is ready to unfollow".upcase
    id = 0
    while @maximums[:unfollows_in_day] < @maximums[:max_unfollows_per_day]
      if @local_stroage[:followed_users].size < @maximums[:max_unfollows_per_day]
        begin
          puts '[+] '.cyan + "Trying to unfollow user [#{followed_users[id]}]"
          unfollow(followed_users[id])
          puts '[+] '.cyan + 'User unfollowed'.upcase.bold.green
          @maximums[:unfollows_in_day] += 1
          id                           += 1
          fall_in_asleep
        rescue Exception => e
          puts "an error detected ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\nignored"
          id += 1
          retry
        end
      else
        puts '[+] '.cyan + '[unfollow per day] is much bigger than [follow per day]'
        exit
      end
    end
  end

  def auto_like
    all_medias	= medias
    puts '[+] '.cyan + "#{all_medias.size} Media is ready to like".upcase
    id 			= 0
    while @maximums[:likes_in_day] < @maximums[:max_likes_per_day]
      begin
        get_media_informations(all_medias[id])
        puts '[+] '.cyan + "Trying to like media [#{all_medias[id]}]"
        like(@informations[:id])
        puts '[+] '.cyan + 'Media liked'.upcase.green.bold
        @maximums[:likes_in_day] += 1
        id                       += 1
        fall_in_asleep
      rescue Exception => e
        puts "an error detected ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\nignored"
        id += 1
        retry
      end
    end
  end

  def auto_comment
    all_medias	= medias
    puts '[+] '.cyan + "#{all_medias.size} Media is ready to send a comment".upcase
    id 			= 0
    while @maximums[:comments_in_day] < @maximums[:max_comments_per_day]
      begin
        get_media_informations(all_medias[id])
        id += 1 if @informations[:comments_disabled]
        puts '[+] '.cyan + "Trying to send a comment to media [#{all_medias[id]}]"
        comment(@informations[:id], generate_a_comment)
        puts '[+] '.cyan + 'comment successfully has been sent'.upcase.green.bold
        @maximums[:comments_in_day] += 1
        id                          += 1
        fall_in_asleep
      rescue Exception => e
        puts "an error detected ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\nignored"
        id += 1
        retry
      end
    end
  end

  def generate_a_comment
    comments 	 = options[:comments]
    first 		   = comments[0].sample
    second 		  = comments[1].sample
    third 		   = comments[2].sample
    fourth		   = comments[3].sample
    fifth 		   = comments[4].sample
    "#{first} #{second} #{third} #{fourth}#{fifth}"
  end

  def check_date
    time = (@tomorrow - Time.new).to_i # => seconds elapsed ...
    if time.zero?
      puts '[+] '.cyan + "It's a new day"
      @local_stroage[:followed_users]   = []
      @local_stroage[:unfollowed_users] = []
      @local_stroage[:liked_medias]     = []
      @local_stroage[:commented_medias] = []
      @maximums[:follows_in_day]        = 0
      @maximums[:unfollows_in_day]      = 0
      @maximums[:likes_in_day]          = 0
      @maximums[:comments_in_day]       = 0
      @tomorrow                         = Time.new + 1.days
      search(options[:tags]) unless @infinite_tags == true
    else
      empty_space = IO.console.winsize[1] - text.size
      empty_space = 0 if empty_space < 0
      print "\r[+] ".cyan + "#{time} seconds remained".upcase
      $stdout.flush
      print ' ' * empty_space
    end
  end

  def fall_in_asleep
    time = options[:wait_per_action]
    puts '[+] '.cyan + "Waiting for #{time} seconds".upcase
    sleep time
  end

  def likes_in_day_are_full?
    @maximums[:likes_in_day] == @maximums[:max_likes_per_day]
  end

  def follows_in_day_are_full?
    @maximums[:follows_in_day] == @maximums[:max_follows_per_day]
  end

  def unfollows_in_day_are_full?
    @maximums[:unfollows_in_day] == @maximums[:max_unfollows_per_day]
  end

  def comments_in_day_are_full?
    @maximums[:comments_in_day] == @maximums[:max_comments_per_day]
  end

  def maximums_are_full?
      likes_in_day_are_full? && follows_in_day_are_full? &&
      unfollows_in_day_are_full? && comments_in_day_are_full?
  end
end
