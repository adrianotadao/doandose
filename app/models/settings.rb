class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  class << self
    def contact_email
      ['adrianotadao@gmail.com', 'saulodasilvasantiago@gmail.com']
    end

    def host_image
      'http://doando.se/assets/'
    end

    def facebook_url
      'www.facebook.com/doando.se'
    end

    def twitter_url
      'http://twitter.com/doandose'
    end
  end
end
