class StepsController < ApplicationController
  # GET /steps
  # GET /steps.xml
  def index
    @steps = Step.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @steps }
    end
  end

  # may go unused
  def show
    step = Step.find(params[:id])
  end

  # GET /steps/new
  # GET /steps/new.xml
  def new
    @step = Step.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @step }
    end
  end

  # GET /steps/1/edit
  def edit
    @step = Step.find(params[:id])
  end

  def create
    @step = Step.new(params[:step])
    @use_case  = UseCase.find(@step.use_case_id)
    @step.position = @use_case.steps.length + 1
    @step.save

    #refresh
    @use_case  = UseCase.find(@step.use_case_id)
  end

  def update
    step = Step.find(params[:id])
     
    step.update_attributes(params[:step])
    step.reload
    unless params[:step][:description].nil?
      render :text => textilize_without_paragraph(step.description)
    else
      render :text => textilize_without_paragraph(step.verify)
    end
  end

  def destroy
    @step = Step.find(params[:id])
    @use_case  = UseCase.find(@step.use_case_id)
    @use_case.update_positions_for_delete(@step.position)
    @step.destroy

    #refresh
    @use_case  = UseCase.find(@step.use_case_id)
  end

  def unformatted_description
    step = Step.find(params[:id])
    render :text => step.description
  end

  def unformatted_verify
    step = Step.find(params[:id])
    render :text => step.verify
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
