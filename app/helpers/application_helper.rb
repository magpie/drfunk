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

  def parens(val)
    if val && val.size
      "(#{val})"
    end
  end

  def safe_textilize(text)
    if text.blank?
      ""
    else
      textilized = RedCloth.new(text, [ :hard_breaks ])
      textilized.hard_breaks = true if textilized.respond_to?(:hard_breaks=)
      textilized.filter_html = true
      textilized.to_html
    end
  end

end

