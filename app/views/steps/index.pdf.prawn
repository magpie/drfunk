pdf.text "#{@scenario.plan.name} > #{@scenario.feature.name}"
pdf.move_down pdf.font.height
pdf.text @scenario.name, :size => 20, :style => :bold

if @scenario.requirement && @scenario.requirement.size > 0
  pdf.text "Requirement ID", :style => :bold
  pdf.text @scenario.requirement
  pdf.move_down pdf.font.height
end

if @scenario.setup && @scenario.setup.size > 0
  pdf.text "Setup", :style => :bold
  pdf.text @scenario.setup
  pdf.move_down pdf.font.height
end

steps = @scenario.steps.map do |step|
 ["#{step.position}.", step.description, step.expected]
end

pdf.table steps, 
  :border_style => :grid,
  :row_colors => ["FFFFFF","EEEEEE"],
  :headers => ["", "Action", "Expected"],
  :align => { 0 => :left, 1 => :left, 2 => :left },
  :vertical_padding => 5,
  :horizontal_padding => 5,
  :column_widths => { 0 => 20, 1 => 260, 2 => 260 }
