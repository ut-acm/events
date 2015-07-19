class LiveController < ApplicationController
	before_action :authenticate_user!
	def choose
		@events=current_user.profile.my_events
	end
end
