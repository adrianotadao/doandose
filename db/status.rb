module Status

  def self.errors(attribute)
    unless attribute.errors.messages.blank?
      puts "#{ model(attribute).first}      contains errors: #{ attribute.errors.messages } *"
    else
      puts "#{ model(attribute).first}      included: #{ model(attribute).last } | status: ok"
    end
  end

  def self.model(attribute)
    case
      when attribute.instance_of?(Blood) then ['Blood', attribute.name]
      when attribute.instance_of?(Campaign) then ['Campaign', attribute.title]
      when attribute.instance_of?(Company) then ['Company', attribute.name]
      when attribute.instance_of?(Notification) then ['Notification', attribute.title]
      when attribute.instance_of?(Person) then ['Person', attribute.name]
      else ['Object unrecognizable', nil]
    end
  end
end