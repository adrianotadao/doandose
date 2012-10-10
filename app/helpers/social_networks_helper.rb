module SocialNetworksHelper
  def facebook
    content_for :javascript do
      "<div id='fb-root'></div>".html_safe
    end
    add_javascript 'http://connect.facebook.net/pt_BR/all.js#xfbml=true', { :async => true }
    default_options = { :href =>  'https://www.facebook.com/doando.se', :layout => 'button_count', :show_faces => false, :class => 'facebook', :font => 'tahoma' }
    haml_tag 'fb:like', default_options
  end

  def twitter
    add_javascript 'http://platform.twitter.com/widgets.js', { :async => true }
    haml_tag :a, :href => "http://twitter.com/share", :class => 'twitter-share-button', 'data-related' => 'doandose',
      'data-count' => 'horizontal', 'data-counturl' => 'http://twitter.com/doandose', 'data-text' => 'ajude uma vida',
      'data-hashtags' => 'doarsangue' do
        haml_concat 'Tweet'
    end
  end
end