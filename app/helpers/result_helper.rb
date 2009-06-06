module ResultHelper

  def result_class(result)
    case result
    when Scenario::RESULT_COMPLETE
      "icon tick"
    else
      "icon page"
    end
  end

end
