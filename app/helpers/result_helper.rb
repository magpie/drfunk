module ResultHelper

  def result_class(result)
    case result
    when Scenario::RESULT_PASSED
      "pass-link"
    when Scenario::RESULT_FAILED
      "fail-link"
    else
      "clear-link"
    end
  end

  def navigation(nav)
    content_for(:navigation) { nav }
  end

  def footer(*links)
    content_for(:footer) { links.join(', ')}
  end

end
