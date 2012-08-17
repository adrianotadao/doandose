class Admin::InformationsController < Admin::BaseController
	def index
		@informations = Information.all
	end

	def show
		@information = Information.find_by_slug params[:id]
	end

	def new
		@information = Information.new
	end

	def create
		@information = Information.new
		if @information.save
			redirect_to admin_informations_path
		else
			render 'new'
		end
	end

	def edit
    @information = Information.find_by_slug params[:id]
	end

	def update

	end

	def destroy
	end
end