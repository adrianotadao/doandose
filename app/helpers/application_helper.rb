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
    message = record.errors[attribute].first
    content_tag :span, message, :class => "error" if message
  end
  
  def menu_item_class(path)
    return 'selected' if current_page?(path)
  end
end
