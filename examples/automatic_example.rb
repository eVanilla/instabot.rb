# lib = File.expand_path('../../lib', __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'instabot'

Config.setup do |set|
  set.username              = 'REPLACE_YOUR_USERNAME'
  set.password              = 'REPLACE_YOUR_PASSWORD'
  set.tags                  = ['test','car','sky','blue','music']
  
  # set.use_proxy            = true # => it's important to enable the proxy usage
  # set.proxy                = ["localhost",8888] # without username and password
  # set.proxy                = ["localhost",8000,"USERNAME","PASSWORD"] # with username and password

  # set.use_tor               = true # default is false
  # set.change_ip_per_actions = # => under construction ...


  set.wait_per_action       = 30
  set.max_follow_per_day    = 500
  set.max_unfollow_per_day  = 400
  set.max_like_per_day      = 400
  set.max_comment_per_day   = 20

  set.log_status            = true
  set.infinite_tags         = true
  set.print_banner          = true
  set.pre_load              = false
  # set.unwanted_list        = ["_id","free_","free"] # => under construction...
  # set.white_list_users     = ["john","alex","nick"] # => under construction...
  set.comments             = [
    %w[this the your],
    %w[photo picture pic shot snapshot],
    %w[is looks feels is really],
    %w[great super good very good good wow WOW cool GREAT magnificent magical very cool stylish beautiful so beautiful so stylish so professional lovely so lovely very lovely glorious so glorious very glorious adorable excellent amazing],
    %w[. .. ... ! !! !!!]
  ]
end

bot = Instabot.new
bot.mode(:infinite) # => :cleanup, :infinite, ...


