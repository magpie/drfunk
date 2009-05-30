module ResultHelper

  def result_class(result)
    case result
    when Scenario::RESULT_COMPLETE
      "pass-link"
    else
      "clear-link"
    end
  end

end
