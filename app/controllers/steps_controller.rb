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

  # GET /steps/1
  # GET /steps/1.xml
  def show
    puts "IN STEP SHOW"
    @step = Step.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @step }
    end
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
      render :text => step.description
    else
      render :text => step.verify
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
end
