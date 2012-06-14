module Admin::CompaniesHelper
  def setup_company(company)
    company.tap do |c|
      c.users.build if c.users.blank?
      c.build_address if c.address.blank?
      c.build_contact if c.contact.blank?
    end
  end
end