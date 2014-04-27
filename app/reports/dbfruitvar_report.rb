class DbfruitvarReport < Prawn::Document

  # Often-Used Constants
  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  TABLE_FONT_SIZE = 8
  TABLE_BORDER_STYLE = :grid

  def header(title=nil)
    image "#{Rails.root}/app/assets/images/IRTA.jpg", height: 30
    if title
      pad_top (10) {text title, size: 14, style: :bold, align: :left}
    end
    pad_bottom(10) {stroke_horizontal_rule}

  end

  def footer(title=nil)
    
    bounding_box [bounds.left, bounds.bottom + 20], :width  => bounds.width do
      stroke_horizontal_rule
      move_down 5
        float do
          if title
           text title, size: 10, style: :bold, align: :left
          end
        end
        float do
          text Time.now.strftime('%d-%m-%Y'), size: 10, style: :bold, align: :right
        end
     
    end

  end

end