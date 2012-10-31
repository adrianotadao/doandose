class PartnerLogo < Asset
  # Constants
  has_mongoid_attached_file :data,
    path: 'public/system/partner_logo/:id/:style.:extension',
    url: '/system/partner_logo/:id/:style.:extension',
    styles: { thumb: '80X50#', medium: '120x75#', large: '200X125#' }
end