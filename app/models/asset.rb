class Asset
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :data

  belongs_to :assetable, polymorphic: true
end