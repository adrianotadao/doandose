module Admin::PartnersHelper
  def setup_partner(partner)
    partner.tap do |r|
      r.build_logo if r.logo.blank?
    end
  end
end