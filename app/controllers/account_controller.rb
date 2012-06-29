#encoding: utf-8

class AccountController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /settings
  def edit
    @account = current_user.account
  end
  
  # PUT /settings
  def update
    @account = current_user.account
    
    if @account.update_attributes(params[:account])
      redirect_to edit_settings_path, notice: 'Nastavenia boli uložené.'
    else
      render action: "edit"
    end
  end
  
end