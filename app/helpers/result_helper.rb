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

end
