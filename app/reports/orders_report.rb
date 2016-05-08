class Admin::OrdersReport < Prawn::Document
  WIDTHS = [150, 200, 170]

  HEADERS = ['Код заказа', 'Дата', 'Сумма (грн)']

  def row(number, date, amount)
    row = [number, date, amount]
    make_table([row]) do |t|
      t.column_widths = WIDTHS
      t.cells.style borders: [:left, :right, :top, :bottom], padding: 5
    end
  end

  def to_pdf
    font_families.update(
      "Verdana" => {
        normal: "#{Rails.root}/app/assets/fonts/verdana.ttf",
        bold: "#{Rails.root}/app/assets/fonts/verdana.ttf",
        italic: "#{Rails.root}/app/assets/fonts/verdana.ttf" })
    font "Verdana", size: 10
    text "Отчет выполненых заказов за #{Time.zone.now.strftime('%m / %Y')}", size: 15, style: :bold, align: :center
    move_down(18)
    @orders = Order.where(status: 2).order('created_at DESC')
    data = []
    items = @orders.each do |order|
      data << row(order.id, order.created_at.strftime('%d.%m.%y %H:%M'), order.total_price)
    end

    head = make_table([HEADERS], column_widths: WIDTHS )
    table([[head], *(data.map{|d| [d]})], header: true) do
      cells.style borders: []
    end
    move_down(15)

    text "Всего выполнено заказов #{@orders.count} на общую сумму #{@orders.to_a.sum{ |order| order.total_price } } грн", size: 12

    creation_date = Time.zone.now.strftime("Отчет сгенерирован %e.%m.%Y в %H:%M")
    go_to_page(page_count)
    move_down(710)
    text creation_date, align: :right, style: :italic, size: 9
    render
  end

end
