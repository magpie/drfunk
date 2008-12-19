module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def navigation(nav)
    content_for(:navigation) { nav }
  end

  def footer(footer)
    content_for(:footer) { footer }
  end

end
