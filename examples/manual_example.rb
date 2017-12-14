require 'instabot'

bot = Instabot.new :manual
bot.login("username","password")

bot.follow('user_id')
bot.unfollow('user_id')
bot.like('user_id')
bot.unlike('user_id')
bot.comment('user_id', 'comment text here')

bot.logout()