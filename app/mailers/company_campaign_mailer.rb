# encoding: utf-8
class CompanyCampaignMailer < ActionMailer::Base
  layout 'mailer'
  include MandrillMailer

  default from: 'suporte@doando.se'

  def alerting(campaign_id, person_id)
    @company_campaign = Campaign.find(person_campaign_id)
    @person = Person.find(person_id)
    mail subject: "Foi criada uma nova campaign na qual precisam de você #{@company_campaign.campaign.title}", to: @person.user.email
  end

  def confirmation(campaign_id)
    @campaign = Campaign.find(campaign_id)
    mail subject: "+ 1 voluntario confirmou a presenca referente a campanha #{@campaign.title}", to: @campaign.company.contact.email
  end

  def undo_confirmation(campaign_id)
    @campaign = Campaign.find(campaign_id)
    mail subject: "Cancelamento de um participante da campanha: #{@campaign.title}", to: @campaign.company.contact.email
  end
end