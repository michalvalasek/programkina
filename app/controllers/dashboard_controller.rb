class DashboardController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @stages = current_user.stages.all
  end

end
