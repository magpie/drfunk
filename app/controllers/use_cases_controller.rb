class UseCasesController < ApplicationController

  # GET /use_cases
  # GET /use_cases.xml
  def index
    @use_cases = UseCase.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @use_cases }
    end
  end

  # GET /use_cases/1
  # GET /use_cases/1.xml
  def show
    @use_case = UseCase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @use_case }
    end
  end

  # GET /use_cases/new
  # GET /use_cases/new.xml
  def new
    @plans = Plan.find(:all)
    @use_case = UseCase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @use_case }
    end
  end

  # GET /use_cases/1/edit
  def edit
    @plans = Plan.find(:all)
    @use_case = UseCase.find(params[:id])
  end

  def create
    @use_case = UseCase.new(params[:use_case])
    @use_case.save

    @plan = Plan.find(params[:use_case][:plan_id])
  end

  def update
    @use_case = UseCase.find(params[:use_case])
    @use_case.category_id = params[:category_id]
    @use_case.save

    @plan = Plan.find(params[:plan_id])
    #@use_case.update_attributes(params[:use_case])

    #redirect_to(@use_case)
  end

  def update_step_order
    order = params[:sort_step_list]
    order.each_with_index do |id, position|
      Step.find(id).update_attribute(:position, position + 1)
    end

    @use_case = UseCase.find(params[:id])
  end

  # DELETE /use_cases/1
  # DELETE /use_cases/1.xml
  def destroy
    @use_case = UseCase.find(params[:id])
    @use_case.destroy

    respond_to do |format|
      format.html { redirect_to(use_cases_url) }
      format.xml  { head :ok }
    end
  end

end
