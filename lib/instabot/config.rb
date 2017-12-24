module Config

    class << self
        attr_accessor :options
    end

    def self.setup
        self.options ||= Configuration.new
        yield(options)
    end

    class Configuration
        attr_accessor   :username, :password, :tags, :use_proxy, :proxy, :comments,
                        :print_banner, :pre_load, :wait_per_action, :infinite_tags,
                        :max_like_per_day, :max_follow_per_day, :max_unfollow_per_day,
                        :max_comment_per_day, :unwanted_list, :white_list_users,
                        :log_status, :use_tor, :add_tag_per_post, :unwanted_list,
                        :white_list_users

        def initialize
            @wait_per_action      = 1 * 60
            @max_comment_per_day  = 50
            @max_follow_per_day   = 50
            @max_like_per_day     = 50
            @max_unfollow_per_day = 50
            @username             = nil
            @password             = nil
            @proxy                = nil
            @username             = nil
            @infinite_tags        = true
            @pre_load             = true
            @print_banner         = true
            @log_status           = true
            @use_proxy            = false
            @use_tor              = false
            @add_tag_per_post     = 1
            @tags                 = []
            @unwanted_list        = []
            @white_list_users     = []
            
            @comments             = [
                %w[this the your],
                %w[photo picture pic shot snapshot],
                %w[is looks feels is really],
                %w[great super good very good good wow WOW cool GREAT magnificent magical very cool stylish beautiful so beautiful so stylish so professional lovely so lovely very lovely glorious so glorious very glorious adorable excellent amazing],
                %w[. .. ... ! !! !!!]
            ]
        end
    end
    
end
