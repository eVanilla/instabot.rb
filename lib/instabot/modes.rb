
# automatic module and helpers
module Modes
  # main def and mode selector
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
    all_users    = users
    id            = 0
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
        puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
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
          puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
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
    all_medias  = medias
    puts '[+] '.cyan + "#{all_medias.size} Media is ready to like".upcase
    id      = 0
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
        puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
        id += 1
        retry
      end
    end
  end

  def auto_comment
    all_medias  = medias
    # puts '[+] '.cyan + "#{all_medias.size} Media is ready".upcase
    id      = 0
    while @maximums[:comments_in_day] < @maximums[:max_comments_per_day]
      begin
        get_media_informations(all_medias[id])
        if @informations[:comments_disabled]
          puts '[-]'.red + 'comments are disable' + "\t[IGNORING]".yellow
          id += 1 
          next
        end
        generated_comment = generate_a_comment
        puts '[+] '.cyan + "Trying to send a comment[#{generated_comment}] to media[#{all_medias[id]}]"
        comment(@informations[:id], generated_comment)
        puts '[+] '.cyan + 'comment has been sent'.upcase.green.bold
        @maximums[:comments_in_day] += 1
        id                          += 1
        fall_in_asleep
      rescue Exception => e
        puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
        id += 1
        retry
      end
    end
  end
  # genrating random comment 
  def generate_a_comment
    comment = ""
    options[:comments].each { |c| comment << " #{c.sample}" }
    comment
  end

  def check_date
    time = (@tomorrow - Time.new).to_i # => remained time ...
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
      time = Time.at(time).utc.strftime("%H:%M:%S")
      print "\r[+] ".cyan + "#{time} remained".upcase + ' '*10 # the empty space
      $stdout.flush
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