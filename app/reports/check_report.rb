class Admin::CheckReport < Prawn::Document

  WIDTHS = [50, 150, 150, 70, 100]
  HEADERS = ['№', 'Категория', 'Продукт', 'Количество', 'Цена (грн)']

  def row(number, category, product, amount, price)
    row = [number, category, product, amount, price]
    make_table([row]) do |t|
      t.column_widths = WIDTHS
      t.cells.style borders: [:left, :right, :top, :bottom], padding: 5
    end
  end

  def to_pdf(order)
    font_families.update(
      "Verdana" => {
        normal: "#{Rails.root}/app/assets/fonts/verdana.ttf",
        bold: "#{Rails.root}/app/assets/fonts/verdana.ttf",
        italic: "#{Rails.root}/app/assets/fonts/verdana.ttf" })
    font "Verdana", size: 10
    text "Товарный чек № #{order.id} от #{order.created_at.strftime("%e.%m.%Y")}", size: 15, style: :bold, align: :center
    move_down(18)

    text "Магазин: Nosh-up, г. Черкассы, ул. Неправдивая, 231"
    move_down(12)

    text "Покупатель: #{order.user.name}"
    move_down(12)

    @line_items = order.line_items
    data = []
    items = @line_items.each_with_index do |li, i|
      data << row(i+1, li.product.category.title, li.product.title, li.quantity, li.product.price)
    end

    head = make_table([HEADERS], column_widths: WIDTHS )
    table([[head], *(data.map{|d| [d]})], header: true) do
      # row(0).style align: :center
      cells.style borders: []
    end
    move_down(12)

    text "Всего наименований #{@line_items.count}, на сумму #{order.total_price} грн", size: 12
    move_down(30)

    text "Отпустил ___________________________"

    render
  end

end
