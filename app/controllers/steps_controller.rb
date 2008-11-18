class StepsController < ApplicationController

  def edit
    @step = Step.find(params[:id])
  end

  def create
    @step = Step.new(params[:step])
    @scenario  = Scenario.find(@step.scenario_id)
    @step.position = @scenario.steps.length + 1
    @step.save

    #refresh
    @scenario  = Scenario.find(@step.scenario_id)
  end

  def update
    step = Step.find(params[:id])
     
    step.update_attributes(params[:step])
    step.reload
    unless params[:step][:description].nil?
      render :text => textilize_without_paragraph(step.description)
    else
      render :text => textilize_without_paragraph(step.expected)
    end
  end

  def destroy
    @step = Step.find(params[:id])
    @scenario  = Scenario.find(@step.scenario_id)
    @scenario.update_positions_for_delete(@step.position)
    @step.destroy

    #refresh
    @scenario  = Scenario.find(@step.scenario_id)
  end

  def unformatted_description
    step = Step.find(params[:id])
    render :text => step.description
  end

  def unformatted_expected
    step = Step.find(params[:id])
    render :text => step.expected
  end

  private

  # rails helper method was not accessible in controller
  def textilize_without_paragraph(text)
    textiled = textilize(text)
    if textiled[0..2] == "<p>" then textiled = textiled[3..-1] end
    if textiled[-4..-1] == "</p>" then textiled = textiled[0..-5] end
    return textiled
  end
end
