#
#   @descriptions  An instagram bot works without instagram api and only needs your username & password 
#   @Authors       eVanilla + https://github.com/eVanilla/instabot.rb/graphs/contributors
# 

%w[colorize mechanize io/console hashie json logger pp active_support/core_ext/numeric/time rbconfig net/telnet socksify socksify/http].each { |gem| require gem }

# main core class
class Instabot

    # including helpers
    include Version
    include Modes
    include Actions
    include Banner
    include Config
    include Grabber
    include Login
    include Log
    include Protocol
    include TorProtocol

    attr_accessor :users, :medias, :media_information, :user_information

    def initialize(mode = :default)
        @login_mode       = mode 
        @users            = []
        @medias           = []
        @log_counter      = 0
        @login_counter    = 1
        @login_status     = false
        @lib_dir          = "#{Dir.pwd}/lib"
        @root_dir         = Dir.pwd.to_s
        @logs_dir         = "#@root_dir/logs"
        @started_time     = Time.new.strftime('%H-%M-%S--%y-%m-%d')
        @errors_iteration = 0 

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

    # will return Config.options... 
    def options
        if @login_mode == :default
            {
                comments:             Config.options.comments,
                max_comment_per_day:  Config.options.max_comment_per_day,
                max_follow_per_day:   Config.options.max_follow_per_day,
                max_like_per_day:     Config.options.max_like_per_day,
                max_unfollow_per_day: Config.options.max_unfollow_per_day,
                username:             Config.options.username,
                password:             Config.options.password,
                pre_load:             Config.options.pre_load,
                print_banner:         Config.options.print_banner,
                proxy:                Config.options.proxy,
                tags:                 Config.options.tags,
                use_proxy:            Config.options.use_proxy,
                use_tor:              Config.options.use_tor,
                wait_per_action:      Config.options.wait_per_action,
                log_status:           Config.options.log_status,
                add_tag_per_post:     Config.options.add_tag_per_post,
                unwanted_list:        Config.options.unwanted_list,
                white_list_users:     Config.options.white_list_users,
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
        create_protocol
        puts '[+] '.cyan + 'Processing successfully completed'
        log('Processing successfully completed', 'CORE')
        unless mode != :default
            login
        end
    end
end
