module SearchHelper

  def scenario_result(scenario)
    result = ""
    matches_name = false

    if include_query(scenario.name) || include_query(scenario.requirement)
      result += "<span class='medium-text'>" + link_to(highlight_query(scenario.name), scenario_steps_path(scenario)) + "</span>"
      if scenario.requirement && scenario.requirement.length > 0
        result += " (" + highlight_query(scenario.requirement) + ")"
      end
      result += "<br/>"
      matches_name = true
    end

    if include_query(scenario.setup)
      result += highlight_query_excerpt(scenario.setup) +  " " 
    end

    for step in scenario.steps
      if include_query(step.description)
        result += highlight_query_excerpt(step.description) + " "
      end

      if include_query(step.expected)
        result += highlight_query_excerpt(step.expected) + " "
      end
    end

    if result.length > 0 && matches_name
      result = "<div>" +result + "</div><br/>"
    elsif result.length > 0 
      previous_results = result
      result = "<div><span class='medium-text'>" + link_to(highlight_query(scenario.name), scenario_steps_path(scenario)) + "</span>" 

      if scenario.requirement && scenario.requirement.length > 0
        result += " (" + scenario.requirement + ")"
      end

      result += "<br/>" 
      result += previous_results
      result += "</div><br/>"
    end

    result
  end

  def highlight_query(attribute)
    highlight(attribute, @query)    
  end

  def highlight_query_excerpt(attribute)
    highlight_query(excerpt(attribute, @query, :radius => 20))
  end

  def include_query(attribute)
    if attribute.nil? || attribute.length == 0
      return false
    end

    return attribute.downcase.include? @query.downcase
  end

end
