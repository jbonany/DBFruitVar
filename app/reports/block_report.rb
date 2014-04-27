
class BlockReport < DbfruitvarReport

  # Often-Used Constants
  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["ID", "Name", "Date", "User"]
  

  def initialize(blocks)
    super()
    @blocks = blocks
    font_size 8
    
    repeat :all do
      header 'Blocks report'
    end

    bounding_box([bounds.left, bounds.top-70], :width => (bounds.width) , :height => (bounds.height)-100) do
      table_content
    end
       
    repeat :all do
      footer 'Blocks report'
    end

    options = { :at => [bounds.right - 150, 0],
        :width => 150,
        :align => :right,
        :start_count_at => 1,
        :font_size => 8}
    number_pages "page <page> of <total>", options
    

  end
 
  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    table block_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
  end
 
  def block_rows
    [['Id', 'Collection', 'Accession', 'Row', 'First tree', 'Last tree', 'Tree number', 'Planting date', 'Pullout date']] +
      @blocks.map do |block|
      [block.id, block.collection.name, block.accession.name, block.row, block.first_tree, block.last_tree, block.tree_number, block.planting_date, block.pullout_date]
    end
  end

end