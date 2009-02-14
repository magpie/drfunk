module StepHelper

  STEP_CHARS_WIDE = 35.0
  SETUP_CHARS_WIDE = 78.0
  LINE_HEIGHT = 15.5

  def step_height(step)
    min_height = 100  
    description_height = text_height(step.description, STEP_CHARS_WIDE)
    expect_height = text_height(step.expected, STEP_CHARS_WIDE)

    if description_height > expect_height
      biggest_height = description_height 
    else
      biggest_height = expect_height 
    end

    if min_height > biggest_height
       return min_height
    else 
       return biggest_height
    end
  end

  def setup_height(setup)
    min_height = 100  
    setup_height = text_height(setup, SETUP_CHARS_WIDE)

    if min_height > setup_height
       return min_height
    else 
       return setup_height
    end
  end

  def text_height(text, chars_wide)
    if text.nil?
      return 0
    end

    lines = 0
    text.each_line do |line| 
      if line.size > chars_wide
        lines += (line.size / chars_wide).ceil
      else 
        lines += 1
      end
    end

    lines * LINE_HEIGHT
  end

end
