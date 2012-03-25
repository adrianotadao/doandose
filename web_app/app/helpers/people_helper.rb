module PeopleHelper
  def setup_test(test)
    test.tap do |r|
      r.build_address if r.address.blank?
      r.build_user if r.user.blank?
      r.build_contact if r.contact.blank?
    end
  end
end
