module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def navigation(nav)
    content_for(:navigation) { nav }
  end

  def footer(*links)
    content_for(:footer) { links.join(', ')}
  end

  def tesc(value, length)
    truncate(h(value), {:length => length})
  end

end
