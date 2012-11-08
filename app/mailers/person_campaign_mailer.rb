# encoding: utf-8
class PersonCampaignMailer < ActionMailer::Base
  layout 'mailer'
  include MandrillMailer

  default from: 'suporte@doando.se'

  def confirm(person_campaign_id)
    @person_campaign = PersonCampaign.find(person_campaign_id)
    mail subject: "Foi criada uma nova campaign na qual precisam de você #{@person_campaign.campaign.title}", to: @person_campaign.person.user.email
  end

  def confirmation(person_campaign_id)
    @person_campaign = PersonCampaign.find(person_campaign_id)
    mail subject: "+ 1 voluntario confirmou a presenca referente a campanha #{@person_campaign.campaign.title}", to: @person_campaign.company.user.email
  end

  def undo_confirmation(person_campaign_id)
    @person_campaign = PersonCampaign.find(person_campaign_id)
    mail subject: "Cancelamento de um participante da campanha: #{@person_campaign.campaign.title}", to: @person_campaign.company.user.email
  end
end