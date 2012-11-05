#encoding: utf-8
module SocialNetworksHelper
  #facebook
  def facebook_like(url, options = {})
    content_for :javascript do
      "<div id='fb-root'></div>".html_safe
    end

    add_javascript 'http://connect.facebook.net/pt_BR/all.js#xfbml=true', { :async => true }

    unless options[:no_override]
      url = 'http://www.facebook.com/doando.se'
    end

    default_options = { :href => url, :layout => 'button_count', :show_faces => false, :class => 'facebook', :font => 'tahoma' }
    haml_tag 'fb:like', default_options.merge(options)
  end

  def facebook_share(label, path)
    link_to_function label, "fbShare('#{path}')"
  end

  def facebook_meta(meta)
    meta.each do |name, content|
      add_meta_property("og:#{name}", content) unless name.blank? && content.blank?
    end
  end

  def facebook_meta_for_notification(notification)
    url = notification.slug
    facebook_meta (
      {
        :title => notification.title,
        :type => 'notificacao',
        :url => url,
        :site_name => 'Dando se',
        :description => truncate( escape_and_sanitize(notification.observation), :length => 120)
      }
    )
  end

  #twitter
  def twitter_like(url, text, options={})
    add_javascript 'http://platform.twitter.com/widgets.js', { :async => true }
    haml_tag :a, :href => "http://twitter.com/share", :class => 'twitter-share-button', 'data-related' => 'doandose',
      'data-count' => 'horizontal', 'data-counturl' => url, 'data-text' => text,
      'data-hashtags' => options[:hash_tags].to_a.join(',').downcase do
        haml_concat 'Tweet'
    end
  end

  def notification_twitt_label(show_url = true, notification)
    label = "#{notification.title} no @doandose! "
    label+= "#{notification_url(notification.slug)}" if show_url
    label
  end

  def campaign_twitt_label(show_url = true, campaign)
    label = "#{campaign.title} no @doandose! "
    label+= "#{campaign_url(campaign.slug)}" if show_url
    label
  end
end