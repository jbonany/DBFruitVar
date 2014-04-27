
class AccessionReport < DbfruitvarReport

  # Often-Used Constants
  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["ID", "Name", "Date", "User"]
  

  def initialize(accessions)
    super(:page_layout => :landscape)
    @accessions = accessions
    font_size 8
    
    repeat :all do
      header 'Accessions report'
    end

    bounding_box([bounds.left, bounds.top-70], :width => (bounds.width) , :height => (bounds.height)-100) do
      table_content
    end
       
    repeat :all do
      footer 'Accessions report'
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
    table accession_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
  end
 
  def accession_rows
    [['Id', 'Name', 'Commercial name', 'Clon name', 'Old code', 'Species', 'Group', 'Synonims' ]] +
      @accessions.map do |accession|
      [accession.id, accession.name, accession.commercial_name, accession.clon_name, accession.oldcode, accession.species.name, accession.group.name, accession.synonims]
    end
  end


  # ... More helpers
end