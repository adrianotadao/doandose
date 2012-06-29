module PeopleHelper
  def setup_person(person)
    person.tap do |c|
      c.build_user if c.user.blank?
      c.build_address if c.address.blank?
      c.build_contact if c.contact.blank?
    end
  end

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
  
  def people_sexes
    [
      ['Masculino', 1],
      ['Feminino', 0],      
    ]
  end
  
  def label_button
    @person.last_step? ? 'Concluir' : 'Proximo'
  end
  
end