# encoding: utf-8
class PeopleController < ApplicationController
  before_filter only: :update do |c|
    c.send(:update_user_password_with_nested_fields, :person)
  end

  def new
    @person = Person.new
  end

  def show
    @person = Person.find_by_slug params[:id]
  end

  def create
    @person = Person.new(params[:person])

    if @person.save
      login @person.user
      redirect_to root_path
    else
      p @person.errors
      render 'new'
    end
  end

  def edit
    @person = Person.find_by_slug params[:id]
  end

  def update
    @person = Person.find_by_slug params[:id]

    if @person.update_attributes(params[:person])
      redirect_to person_path(@person.name), notice: t('flash.people.update.notice')
    else
      render action: :edit
    end
  end
end