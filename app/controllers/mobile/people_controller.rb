class Mobile::PeopleController < Mobile::MobilesController
  def new
    @person = Person.new
  end
end