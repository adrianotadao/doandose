class CampaignsController < ApplicationController
	def index
		@campaigns = Campaign.scoped
	end

	def show
		@campaign = Campaign.find_by_slug params[:id]
	end
end