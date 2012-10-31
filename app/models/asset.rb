class Asset
  # Includes
  include Mongoid::Document
  include Mongoid::Paperclip

  # Constants
  has_mongoid_attached_file :data

  # Relationships
  belongs_to :assetable, polymorphic: true
end