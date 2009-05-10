module SearchHelper

  def highlight_query(attribute, query)
    highlight(attribute, query)    
  end

  def highlight_query_excerpt(attribute, query)
    if attribute && attribute.downcase.include?(query.downcase)
      highlight_query(excerpt(attribute, query, :radius => 20), query)
    end
  end

  def hl_if_query(text)
    if params[:query]
      highlight_query(text, params[:query])
    else
      text
    end
  end

end
