module CampaignsHelper
  def participate_button_campaign(campaign)
    if user_signed_in?
      participate = campaign.will_participate(current_user.authenticable)
      if participate.present? && participate.non_canceled?
        link_to t('buttons.non_participate'), undo_confirm_campaign_path(campaign), class: 'link gray'
      else
        link_to t('buttons.participate'), campaign_path(campaign), class: 'link red'
      end
    else
      link_to t('buttons.participate'), campaign_path(campaign), class: 'link red'
    end
  end
end