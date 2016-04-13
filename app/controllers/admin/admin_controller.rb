class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :check_admin_and_manager

  def index
    @orders = Order.where(status: 0).page(params[:page]).order(:status)
    @quantity_orders = @orders.count
    @users = User.where('created_at >= ?', Time.zone.now - 1.day).where(role: 1)
    @quantity_users = @users.count
  end

  private

    def get_collect_categories
      @categoies = Category.all
    end

end
