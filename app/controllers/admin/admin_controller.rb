class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :admin_only

  def index
  end

  private

    def get_collect_categories
      @categoies = Category.all
    end

end
