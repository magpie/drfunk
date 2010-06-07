module SearchHelper

  def highlight_excerpt(attribute, query)
    if attribute && attribute.downcase.include?(query.downcase)
      highlight(excerpt(attribute, query, :radius => 20), query)
    end
  end

  def hl_if_query(text)
    if params[:query]
      highlight(text, params[:query])
    else
      text
    end
  end

end
