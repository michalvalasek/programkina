class PublicController < ApplicationController
  layout "public"
  
  def index
    @providers = Account.all
  end
  
  def contact
  end
end
