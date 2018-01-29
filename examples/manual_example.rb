# lib = File.expand_path('../../lib', __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'instabot'

bot = Instabot.new :manual
bot.login("REPLACE_YOUR_USERNAME","REPLACE_YOUR_PASSWORD")

bot.follow('user_id')
bot.unfollow('user_id')
bot.like('user_id')
bot.unlike('user_id')
bot.comment('user_id', 'comment text here')

bot.logout()