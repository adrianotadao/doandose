class PartnerLogo < Asset
  has_mongoid_attached_file :data,
    :path => "public/system/:id/:style.:extension",
    :url => "/system/:id/:style.:extension",
    :styles => { :thumb => '200x200' }
end