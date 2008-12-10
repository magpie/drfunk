module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def footer(footer)
    content_for(:footer) { footer }
  end

end
