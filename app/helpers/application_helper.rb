# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def status_icon(status)
    case status
    when UseCase::NO_RESULT  
      return ""
    when UseCase::PASS_RESULT
      return image_tag("tick.png")
    when UseCase::FAIL_RESULT
      return "<font style='color:#900;'>FAIL</font>"
    end 
  end

end
