class Admin::SpoiledFoodsReport < Prawn::Document
  WIDTHS = [150, 200, 170]

  HEADERS = ['Продукт', 'Вес, кг', 'Сумма, грн']

  def row(title, weight, amount)
    row = [title, weight, amount]
    make_table([row]) do |t|
      t.column_widths = WIDTHS
      t.cells.style borders: [:left, :right, :top, :bottom], padding: 5
    end
  end

  def to_pdf(date)
    @date = date.to_date
    font_families.update(
      "Verdana" => {
        normal: "#{Rails.root}/app/assets/fonts/verdana.ttf",
        bold: "#{Rails.root}/app/assets/fonts/verdana.ttf",
        italic: "#{Rails.root}/app/assets/fonts/verdana.ttf" })
    font "Verdana", size: 10
    text "Отчет списаных продуктов за #{@date.strftime('%m / %Y')}", size: 15, style: :bold, align: :center
    move_down(18)
    @spoiled_foods = SpoiledFood.where("extract(year from created_at) = ? and extract(month from created_at) = ?", @date.year, @date.month).order('created_at DESC')
    data = []
    items = @spoiled_foods.each do |spoiled_food|
      data << row(spoiled_food.food.title, spoiled_food.weight, spoiled_food.total_price)
    end

    head = make_table([HEADERS], column_widths: WIDTHS )
    table([[head], *(data.map{|d| [d]})], header: true) do
      cells.style borders: []
    end
    move_down(15)
    text "Общий вес списанных продуктов #{@spoiled_foods.to_a.sum{ |i| i.weight }} кг", size: 12
    move_down(10)
    text "Общий убыток #{@spoiled_foods.to_a.sum{ |i| i.total_price }} грн", size: 12

    creation_date = Time.zone.now.strftime("Отчет сгенерирован %e.%m.%Y в %H:%M")
    go_to_page(page_count)
    move_down(710)
    text creation_date, align: :right, style: :italic, size: 9
    render
  end

end
