# encoding: utf-8
class PeopleController < ApplicationController
  before_filter only: :update do |c|
    c.send(:update_user_password_with_nested_fields, :person)
  end

  before_filter :authenticate_user!, only: [:edit, :update]

  def new
    if current_user
      redirect_to edit_person_path(Person.find(current_user.authenticable_id))
    else
      @person = Person.new
      @bloods = Blood.all
    end
  end

  def show
    @person = Person.find_by_slug params[:id]
    @person_notifications = @person.person_notifications.paginate( per_page: 3, page: params[:page])
  end

  def create
    @person = Person.new(params[:person])

    if @person.save
      login @person.user
      redirect_to root_path
    else
      p @person.errors
    end
  end

  def edit
    @person = Person.find_by_slug params[:id]
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
end