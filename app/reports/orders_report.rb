class Admin::OrdersReport < Prawn::Document
  WIDTHS = [100, 150, 120, 150]

  HEADERS = ['Номер заказа', 'Дата', 'Сумма (грн)', 'Статус']

  def row(number, date, amount, status)
    row = [number, date, amount, status]
    make_table([row]) do |t|
      t.column_widths = WIDTHS
      t.cells.style borders: [:left, :right], padding: 5
    end
  end

  def to_pdf
    font_families.update(
      "Verdana" => {
        normal: "#{Rails.root}/app/assets/fonts/verdana.ttf",
        bold: "#{Rails.root}/app/assets/fonts/verdana.ttf",
        italic: "#{Rails.root}/app/assets/fonts/verdana.ttf" })
    font "Verdana", size: 10
    text "Отчет продаж за #{Time.zone.now.strftime('%m / %Y')}", size: 15, style: :bold, align: :center
    move_down(18)
    @orders = Order.order('created_at DESC')
    data = []
    items = @orders.each do |order|
      data << row(order.id, order.created_at.strftime('%d.%m.%y %H:%M'), order.total_price, order.status)
    end

    head = make_table([HEADERS], column_widths: WIDTHS )
    table([[head], *(data.map{|d| [d]})], header: true, row_colors: %w[F5F5F5 FFFFFF]) do
      row(0).style background_color: 'F5F5F5' #, text_color: '000000'
      cells.style borders: []
    end

    creation_date = Time.zone.now.strftime("Отчет сгенерирован %e.%m.%Y в %H:%M")
    go_to_page(page_count)
    move_down(710)
    text creation_date, align: :right, style: :italic, size: 9
    render
  end

end
