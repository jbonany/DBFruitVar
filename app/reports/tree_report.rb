
class TreeReport < DbfruitvarReport

  # Often-Used Constants
  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["ID", "Name", "Date", "User"]
  

  def initialize(trees)
    super()
    @trees = trees
    font_size 8
    
    repeat :all do
      header 'Trees report'
    end

    bounding_box([bounds.left, bounds.top-70], :width => (bounds.width) , :height => (bounds.height)-100) do
      table_content
    end
       
    repeat :all do
      footer 'Trees report'
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
    table tree_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
  end
 
  def tree_rows
    [['Id', 'Block', 'Tree', 'Row', 'Planting date', 'Pullout date', 'Rootstock']] +
      @trees.map do |tree|
      [tree.id, tree.block_id, tree.tree, tree.row, tree.planting_date, tree.pullout_date, tree.rootstock]
    end
  end

end