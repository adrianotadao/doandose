class Users::IdentitiesController < ApplicationController
  # include Users::Session

  # def new
  #   @user = Users::User.new
  # end

  # def create
  #   @user = User.new(params[:users_user])

  #   if @user.save
  #     login @user
  #     redirect_to root_path
  #   else
  #     render '/identities/new'
  #   end
  # end

  # def edit
  #   if user_signed_in?
  #     @user = current_user
  #     @authentications = User.social_networks(@user)
  #   else
  #     redirect_to new_user_path
  #   end
  # end

  # def update
  #   @user = current_user
  #   if @user.update_attributes(params[:users_user])
  #     logout
  #     login(@user)
  #     redirect_to root_path
  #   else
  #     render '/identities/edit'
  #   end
  # end

end

