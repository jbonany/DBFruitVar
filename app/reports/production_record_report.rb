
class ProductionRecordReport < DbfruitvarReport

  # Often-Used Constants
  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["ID", "Name", "Date", "User"]
  

  def initialize(production_records)
    super(:page_layout => :landscape)
    @production_records = production_records
    font_size 7
    
    repeat :all do
      header 'Production records report'
    end

    bounding_box([bounds.left, bounds.top-70], :width => (bounds.width) , :height => (bounds.height)-100) do
      table_content
    end
       
    repeat :all do
      footer 'Production records report'
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
    table production_records_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      columns(10..20).style :align => :right 
      columns(0).width = 30
      columns(1..2).width = 40
      columns(3).width = 90
      columns(4..6).width = 25
      columns(7..8).width = 45
      columns(9).width = 35
      columns(10).width = 50
      columns(11..20).width = 30

      columns_width = {1 => 15}
    end
  end
 
  def production_records_rows
       
    [['Block Id', 'Location', 'Species', 'Name', 'Row', 'First tree', 'Last tree', 'Planting date',
      'Harvest date', 'Tree number', 'Production', 'C90', 'C8590', 'C8085', 'C7580', 'C7275', 'C7072', 'C6870', 'C6568', 'C65']] +
  
    @production_records.map do |production_record|

      [production_record.block.id,
       production_record.block.collection.location.acronym,
       production_record.block.collection.species.acronym,
       production_record.block.accession.name,
       production_record.block.row,
       production_record.block.first_tree,
       production_record.block.last_tree,
       production_record.block.planting_date,  
       production_record.harvest_date,  
       production_record.tree_number,  
       production_record.production, 
       production_record.c90,  
       production_record.c8590,  
       production_record.c8085,  
       production_record.c7580,  
       production_record.c7275,  
       production_record.c7072,  
       production_record.c6870,  
       production_record.c6568,  
       production_record.c65]
    
    end
     

  end

end