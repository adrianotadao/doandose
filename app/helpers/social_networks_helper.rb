module SocialNetworksHelper
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

  def twitter_like(url, text, options={})
    add_javascript 'http://platform.twitter.com/widgets.js', { :async => true }
    haml_tag :a, :href => "http://twitter.com/share", :class => 'twitter-share-button', 'data-related' => 'doando.se',
      'data-count' => 'horizontal', 'data-counturl' => url, 'data-text' => text,
      'data-hashtags' => options[:hash_tags].to_a.join(',').downcase do
        haml_concat 'Tweet'
    end
  end
end