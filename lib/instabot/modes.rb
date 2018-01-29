# modes module and helpers
module Modes
  # main def and mode selector
  def mode(mode = :default)
    case mode
    when :infinite
      puts '[+] '.cyan + '[Auto] mode is turned on'.yellow
      log('[Auto] mode is turned on', 'MODES')
      search(options[:tags])
      @tomorrow = Time.new + 1.days
      actions = %w[follow unfollow like comment]
      loop do
        if !maximums_are_full?
          action = actions.sample
          case action
          when 'follow'
            if !follows_in_day_are_full?
              auto_follow
            end
          when 'unfollow'
            if !unfollows_in_day_are_full?
              auto_unfollow
            end
          when 'like'
            if !likes_in_day_are_full?
              auto_like
            end
          when 'comment'
            if !comments_in_day_are_full?
              auto_comment
            end
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
        fall_in_asleep
      end
    when :default
      puts '[-] '.cyan + 'Please choose a mode'.upcase.red
    else
      puts '[-] '.cyan + 'Please choose a mode'.upcase.red
    end
  end

  def auto_follow
    all_users    = @users
    search(options[:tags]) if all_users == [] || all_users.nil?
    @follows_auto_increment           = 0
    puts '[+] '.cyan + "[follow] ".upcase.yellow.bold + "#{all_users.size} user is ready".upcase
    while @maximums[:follows_in_day] < @maximums[:max_follows_per_day]
      begin
        @users -= all_users[@follows_auto_increment] if all_users[@follows_auto_increment].nil? || all_users[@follows_auto_increment] == []
        handle_user_information_data_by_user_id(all_users[@follows_auto_increment])
        if !is_user_valid?(@user_information[:full_name])
          puts '[+] '.cyan + "Trying to follow user [#{all_users[@follows_auto_increment]}]"
          follow(@user_information[:id])
          @users -= [all_users[@follows_auto_increment]]
          puts '[+] '.cyan + 'User followed'.upcase.green.bold
          @maximums[:follows_in_day] += 1
          @follows_auto_increment += 1
          fall_in_asleep
        else
          puts "unwanted user(#{@user_information[:full_name]}) [ignored]".yellow
          @follows_auto_increment += 1
        end
        break
      rescue Exception => e
        puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
        @follows_auto_increment += 1
        break
        retry
      end
    end
  end

  def auto_unfollow
    followed_users = @local_stroage[:followed_users]
    puts '[+] '.cyan + "[unfollow] ".upcase.yellow.bold + "#{followed_users.size} user is ready".upcase
    @unfollows_auto_increment = 0
    while @maximums[:unfollows_in_day] < @maximums[:max_unfollows_per_day]
      if @local_stroage[:followed_users].size < @maximums[:max_unfollows_per_day]
        if !followed_users.empty?
          begin
            puts '[+] '.cyan + "Trying to unfollow user [#{followed_users[@unfollows_auto_increment]}]"
            unfollow(followed_users[@unfollows_auto_increment])
            @local_stroage[:followed_users] -= [followed_users[@unfollows_auto_increment]]
            puts '[+] '.cyan + 'User unfollowed'.upcase.bold.green
            @maximums[:unfollows_in_day] += 1
            @unfollows_auto_increment += 1
            fall_in_asleep
            break
          rescue Exception => e
            puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
            @unfollows_auto_increment += 1
            break
          end
        else 
          break
        end
      else
        puts '[-] '.red + '[unfollow per day] is much bigger than [follow per day]'.upcase.red.bold
        exit!
      end
    end
  end

  def auto_like
    all_medias  = @medias
    search(options[:tags]) if all_medias == [] || all_medias.nil?
    puts '[+] '.cyan + "[like] ".upcase.yellow.bold + "#{all_medias.size} Media is ready".upcase
    while @maximums[:likes_in_day] < @maximums[:max_likes_per_day]
      begin
        @medias -= [all_medias[@likes_auto_increment]] if all_medias[@likes_auto_increment].nil? || all_medias[@likes_auto_increment] == []
        handle_media_information_data(all_medias[@likes_auto_increment])
        puts '[+] '.cyan + "Trying to like media [#{all_medias[@likes_auto_increment]}]"
        like(@media_information[:id])
        @medias -= [all_medias[@likes_auto_increment]]
        puts '[+] '.cyan + 'Media liked'.upcase.green.bold
        @maximums[:likes_in_day] += 1
        fall_in_asleep
        break
      rescue Exception => e
        puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
        @medias -= [all_medias[@likes_auto_increment]]
        break
      end
    end
  end

  def auto_comment
    all_medias  = @medias
    search(options[:tags]) if all_medias == [] || all_medias.nil?
    puts '[+] '.cyan + "[comment] ".upcase.yellow.bold + "#{all_medias.size} Media is ready".upcase
    @comments_auto_increment      = 0
    while @maximums[:comments_in_day] < @maximums[:max_comments_per_day]
      begin
        @medias -= [all_medias[@comments_auto_increment]] if all_medias[@comments_auto_increment].nil? || all_medias[@comments_auto_increment] == []
        handle_media_information_data(all_medias[@comments_auto_increment])
        if @media_information[:comments_disabled]
          puts '[-]'.cyan + 'comments are disable' + "\t[ignored]".yellow
          @comments_auto_increment += 1 
        end
        generated_comment = generate_a_comment
        puts '[+] '.cyan + "Trying to send a comment[#{generated_comment}] to media[#{all_medias[@comments_auto_increment]}]"
        comment(@media_information[:id], generated_comment)
        @medias -= [all_medias[@comments_auto_increment]]
        puts '[+] '.cyan + 'comment has been sent'.upcase.green.bold
        @maximums[:comments_in_day] += 1
        fall_in_asleep
        break
      rescue Exception => e
        puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
        @comments_auto_increment += 1
        break
      end
    end
  end

  # genrating random comment 
  def generate_a_comment
    comment = ""
    options[:comments].each { |c| comment << " #{c.sample}" }
    comment
  end

  def is_user_valid?(user)
    if options[:white_list_users].include?(user)
      options[:unwanted_list].find { |unwanted| unwanted =~ /#{user}/ } != nil 
    else
      return false
    end
  end


  def check_date
    time = (@tomorrow - Time.new).to_i # => remained time ...
    if time.zero?
      puts '[+] '.cyan + "[new day]".upcase
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

  def fall_in_asleep(time=options[:wait_per_action])
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
