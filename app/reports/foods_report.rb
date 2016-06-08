class Admin::FoodsReport < Prawn::Document
  WIDTHS = [150, 200, 170]

  HEADERS = ['Продукт', 'Вес, кг', 'Окончание срока годности']

  def row(title, weight, amount)
    row = [title, weight, amount]
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
    text "Остаток продуктов на складе", size: 15, style: :bold, align: :center
    move_down(18)
    @foods = Food.all.order('title DESC')
    data = []
    items = @foods.each do |food|
      data << row(food.title, food.weight, food.expiry_date)
    end

    head = make_table([HEADERS], column_widths: WIDTHS )
    table([[head], *(data.map{|d| [d]})], header: true) do
      cells.style borders: []
    end
    move_down(15)

    creation_date = Time.zone.now.strftime("Отчет сгенерирован %e.%m.%Y в %H:%M")
    go_to_page(page_count)
    move_down(710)
    text creation_date, align: :right, style: :italic, size: 9
    render
  end

end
