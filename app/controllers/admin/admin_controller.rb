class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :admin_only

  def index
  end
  
end
