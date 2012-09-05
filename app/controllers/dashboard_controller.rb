#encoding: utf-8

class DashboardController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @stages = current_user.stages.all
    @notification = current_user.account.notification
  end
  
  def set_notification
    if current_user.account.update_attribute(:notification, params[:notification])
      redirect_to dashboard_path, notice: "Notifikácia bola nastavená."
    else
      redirect_to dashboard_path, error: "Notifikácia nebola nastavená."
    end
  end
  
  def clear_notification
    current_user.account.update_attribute(:notification, "")
    redirect_to dashboard_path, notice: "Notifikácia bola zrušená."
  end

end
