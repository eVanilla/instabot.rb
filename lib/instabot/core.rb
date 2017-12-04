%w[colorize mechanize io/console hashie json logger pp active_support/core_ext/numeric/time rbconfig].each { |gem| require gem }

class Instabot
  include Version
  include Modes
  include Actions
  include Banner
  include Config
  include Grabber
  include Login
  include Log
  include Protocol

  attr_accessor :users, :medias

  def initialize(mode = :default)
    @login_mode    = mode
    @users         = []
    @medias        = []
    @log_counter   = 0
    @login_counter = 1
    @login_status  = false
    @lib_dir       = "#{Dir.pwd}/lib"
    @root_dir      = Dir.pwd.to_s
    @logs_dir      = "#@root_dir/logs"
    @global_time   = Time.new.strftime('%H-%M-%S--%y-%m-%d')
    Configuration.new if @login_mode == :manual

    @local_stroage = {
      followed_users:   [],
      unfollowed_users: [],
      liked_medias:     [],
      unliked_medias:   [],
      commented_medias: []
    }

    @maximums = {
      follows_in_day:        0,
      unfollows_in_day:      0,
      likes_in_day:          0,
      comments_in_day:       0,
      max_follows_per_day:   options[:max_follow_per_day],
      max_unfollows_per_day: options[:max_unfollow_per_day],
      max_likes_per_day:     options[:max_like_per_day],
      max_comments_per_day:  options[:max_comment_per_day]
    }

    intro(mode)
  end

  def options
    if @login_mode == :default
      {
        comments:             Config.options.comments,
        max_comment_per_day:  Config.options.max_comment_per_day,
        max_follow_per_day:   Config.options.max_follow_per_day,
        max_like_per_day:     Config.options.max_like_per_day,
        max_unfollow_per_day: Config.options.max_unfollow_per_day,
        password:             Config.options.password,
        pre_load:             Config.options.pre_load,
        print_banner:         Config.options.print_banner,
        proxy:                Config.options.proxy,
        tags:                 Config.options.tags,
        unwanted_list:        Config.options.unwanted_list,
        use_proxy:            Config.options.use_proxy,
        username:             Config.options.username,
        wait_per_action:      Config.options.wait_per_action,
        white_list_users:     Config.options.white_list_users
      }
    else
      {
        max_comment_per_day:  :infinite,
        max_follow_per_day:   :infinite,
        max_like_per_day:     :infinite,
        max_unfollow_per_day: :infinite
      }
    end
  end

  def intro(mode)
    trap('INT') { exit! }
    print_banner
    check_log_files
    log('log files are checked', 'CORE')
    log('Machine started', 'CORE')
    create_mechanic
    puts '[+] '.cyan + 'Processing successfully completed'
    log('Processing successfully completed', 'CORE')
    unless mode != :default
      login
    end
  end
end
