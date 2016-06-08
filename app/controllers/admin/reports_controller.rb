class Admin::ReportsController < Admin::AdminController

  def download_success_orders_pdf
    output = Admin::OrdersReport.new.to_pdf(params[:date])
    @date = params[:date].to_date
    send_data output, type: 'application/pdf', filename: "success_orders(#{@date.month}.#{@date.year}).pdf"
  end

  def download_cancel_porducts_pdf
    output = Admin::SpoiledFoodsReport.new.to_pdf(params[:date])
    @date = params[:date].to_date
    send_data output, type: 'application/pdf', filename: "spoiled_foods(#{@date.month}.#{@date.year}).pdf"
  end

  def download_foods_pdf
    output = Admin::FoodsReport.new.to_pdf
    send_data output, type: 'application/pdf', filename: "foods.pdf"
  end

end
