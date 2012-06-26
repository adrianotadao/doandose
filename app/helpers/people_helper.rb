module PeopleHelper
  def path_locale(attribute)
    t("label.user.confirmation_step.#{attribute}")
  end
  
  def people_markers
    markers = []
    Person.actives.all.map(&:address).each do |address|
      markers << address.full_coordinate if address.full_coordinate
    end
    markers   
  end
  
end