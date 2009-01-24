class ResultsController < ApplicationController

  def update
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.update_attribute(:result, params[:result])

    respond_to do |format|
      format.js
    end
  end

end
