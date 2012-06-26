module Admin::CompaniesHelper
  def setup_company(company)
    company.tap do |c|
      c.build_user if c.user.blank?
      c.build_address if c.address.blank?
      c.build_contact if c.contact.blank?
    end
  end
end