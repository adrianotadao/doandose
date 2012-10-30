module PeopleHelper
  def setup_people(person)
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
      ['Masculino', 'm'],
      ['Feminino', 'f'],
    ]
  end

  def formated_birthdate(birthdate)
    unless birthdate.blank?
      p birthdate
      p birthdate.strftime('%d/%m/%Y')
      birthdate.strftime('%d/%m/%Y')
    else
      ''
    end
  end
end