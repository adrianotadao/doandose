module ApplicationHelper
  def title(title)
    content_for(:title){ title }
  end

  def full_title(title)
    content_for(:full_title){ title }
  end

  def page_title
    if content_for(:full_title).present?
      content_for(:full_title)
    elsif content_for(:title).present?
      "doando.se - #{content_for(:title)}"
    else
      "doando.se"
    end
  end

  def error_for(record, attribute)
    unless record.errors[attribute].blank?
      message = record.errors[attribute].first
      if message
        content_tag :span, class: "error #{attribute.to_s}" do
          message
        end
      end
    end
  end

  def menu_item_class(path)
    return 'selected' if current_page?(path)
  end

  def label_boolean(label)
    label ? 'Sim' : 'Nao'
  end

  def formated_date(date)
      unless date.blank?
        date.strftime('%d/%m/%Y')
      else
        ''
      end
  end

  #include javascript
  def add_javascript(url, options = {})
    return unless content_for(:javascript).to_s.match(url).blank?
    content_for :javascript do
      javascript_include_tag(url, options)
    end
  end

  #scape to string
  def escape_and_sanitize(string)
    escape_javascript( strip_tags(string) )
  end

  def add_meta_property(property, content)
    content_for :meta do
      tag :meta, :property => property, :content => content
    end
  end
end