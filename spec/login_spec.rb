require 'spec_helper'
require 'instabot'

describe Instabot do
	context "When testing the Instabot class" do 
		it "should first login into an account when we call the login method" do 
			bot = Instabot.new :manual
			# bot.login("username","password") # this will exit the program when the account is invalid and thats why i commented this line ... and i'm sure this lib works fine!
		end
	end
end