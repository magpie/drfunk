module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def navigation(nav)
    content_for(:navigation) { nav }
  end

  def footer(*links)
    content_for(:footer) { links.join(', ').html_safe}
  end

  def trunk(value, length)
    truncate(value, {:length => length})
  end

  def parens(val)
    if val && val.size > 0
      "(#{val})"
    else
      ""
    end
  end

  def safe_textilize(text)
    if text.blank?
      ""
    else
      textilized = RedCloth.new(text, [ :hard_breaks ])
      textilized.extend CustomTags
      textilized.hard_breaks = true if textilized.respond_to?(:hard_breaks=)
      textilized.filter_html = true if textilized.respond_to?(:filter_html=)
      textilized.to_html.html_safe
    end
  end

  FIVE_MINUTES = 5 * 60

  def warn_if_recent_update(scenario)
    if ((Time.now - scenario.updated_at) < FIVE_MINUTES)
      "class='warn'"
    end
  end

  module CustomTags
    def failure(opts)
      "<p class='failure'><b>FAILURE</b> " + opts[:text] + "</p>"
    end
  end

end

