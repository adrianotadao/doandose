# encoding: utf-8
class PeopleController < ApplicationController
  before_filter only: :update do |c|
    c.send(:update_user_password_with_nested_fields, :person)
  end

  before_filter :authenticate_user!, only: [:show, :edit, :update]

  def new
    if current_user
      redirect_to edit_person_path(current_user.authenticable)
    else
      @person = Person.new
    end
  end

  def show
    @person = current_user.authenticable
    @person_notifications = @person.person_notifications.non_canceleds.paginate( per_page: 3, page: params[:page])
  end

  def create
    @person = Person.new(params[:person])

    if @person.save
      login @person.user
      redirect_to root_path
    else
     render action: 'new'
    end
  end

  def edit
    @person = current_user.authenticable
    @user = current_user
    @authentications = User.social_networks(@user)
  end

  def update
    @person = Person.find_by_slug params[:id]

    if @person.update_attributes(params[:person])
      update_user_cookie(@person.user)
      redirect_to person_path(@person), notice: t('flash.people.update.notice')
    else
      render action: :edit
    end
  end

  def email_in_use
    email = true if user_signed_in? && current_user.email == params[:email]
    email = !User.where(:email => /^#{params[:email]}/i).first if email.blank?
    render :json => email
  end
end