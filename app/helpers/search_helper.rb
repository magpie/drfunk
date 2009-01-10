module SearchHelper

  def search_result(feature)
    result = ""
    matches_name = false

    if @query.nil? || @query.length == 0
      return result
    end

    for scenario in feature.scenarios
      result += scenario_result(scenario)
    end

    if result.length > 0
      return "<div class='medium-text'>" + feature.name + "</div>" + result
    end

    result
  end

  def scenario_result(scenario)
    result = ""

    if include_query(scenario.name) || include_query(scenario.requirement)
      result += link_to(highlight_query(scenario.name), scenario_steps_path(scenario))
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
      result = "<div style='padding-bottom:10px'>" +result + "</div>"
    elsif result.length > 0 
      previous_results = result
      result = "<div style='padding-bottom:10px'>" + link_to(highlight_query(scenario.name), scenario_steps_path(scenario))

      if scenario.requirement && scenario.requirement.length > 0
        result += " (" + scenario.requirement + ")"
      end

      result += "<br/>" 
      result += previous_results
      result += "</div>"
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
