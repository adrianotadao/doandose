class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  class << self
    def contact_email
      ['adrianotadao@gmail.com', 'saulodasilvasantiago@gmail.com']
    end
  end
end
