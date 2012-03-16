class ActivitiesController < ApplicationController
  before_filter :login_required
  before_filter :per_load
  def per_load
    @activity = Activity.find(params[:id]) if params[:id]  
  end
  
  def new
    @activity = Activity.new
  end
  
  def create
    @activity = Activity.new(params[:activity])
    @activity.creator = current_user
    if @activity.save
      return redirect_to "/activities"
    end
    
    error = @activity.errors.first
    flash[:error] = "#{error[0]} #{error[1]}"
    redirect_to "/activities/new"
  end
  
  def show
  end
  
  def index
    @week_activities_data = current_user.the_week_activities_data
  end
end
