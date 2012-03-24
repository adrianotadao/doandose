module PeopleHelper
  def setup_highlight(highlight)
    highlight.tap do |r|
      r.build_banner if r.banner.blank?
    end
  end
end
