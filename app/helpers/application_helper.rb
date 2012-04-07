module ApplicationHelper
  
  def blood_types
    
  end
  
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
end