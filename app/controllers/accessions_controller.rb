class AccessionsController < ApplicationController
  before_action :set_accession, only: [:show, :edit, :update, :destroy]
 
  # GET /accessions
  # GET /accessions.json
  def index

    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Country.per_page 
    end

    @search = Accession.ransack(params[:q])
    @accessions = @search.result.paginate(:page => params[:page], :per_page => @per_page)

    respond_to do |format|
      format.html
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = AccessionReport.new(@search.result)
        send_data pdf.render, filename: 'accessions_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end
  end

  # GET /accessions/1
  # GET /accessions/1.json
  def show
  end

  # GET /accessions/new
  def new
    @accession = Accession.new
  end

  # GET /accessions/1/edit
  def edit
  end

  # POST /accessions
  # POST /accessions.json
  def create
    @accession = Accession.new(accession_params)

    respond_to do |format|
      if @accession.save
        format.html { redirect_to @accession, notice: 'Accession was successfully created.' }
        format.json { render action: 'show', status: :created, location: @accession }
      else
        format.html { render action: 'new' }
        format.json { render json: @accession.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accessions/1
  # PATCH/PUT /accessions/1.json
  def update
    respond_to do |format|
      if @accession.update(accession_params)
        format.html { redirect_to @accession, notice: 'Accession was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @accession.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accessions/1
  # DELETE /accessions/1.json
  def destroy
    @accession.destroy
    respond_to do |format|
      format.html { redirect_to accessions_url }
      format.json { head :no_content }
    end
  end

  def report
  
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Location.per_page 
    end
    
    @search = Accession.ransack(params[:q])
    @search.build_grouping unless @search.groupings.any?
    @accessions = @search.result.paginate(:page => params[:page], :per_page => @per_page)
    #@search.build_condition

    @url_report = report_accessions_path

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = AccessionReport.new(@search.result)
        send_data pdf.render, filename: 'accessions_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end

  def summary_report
  
    @per_page = 1
       
    @search = Accession.ransack(params[:q])
    @search.build_grouping unless @search.groupings.any?
    @accessions = @search.result.paginate(:page => params[:page], :per_page => @per_page) 

    @blocks = Block.where(accession_id: @accessions.first.id).ids
    @productions = ProductionRecord.joins(:block).select("(YEAR(production_records.harvest_date) - YEAR(blocks.planting_date)) AS yp, \
                                                           SUM(production) / SUM(production_records.tree_number) / 1000 AS production_per_tree") \
                                                 .where(block_id: @blocks) \
                                                 .group("yp")
    @production_by_year = [['Year', 'Production']] +
      @productions.map do |production|
      [production.yp.round(2), production.production_per_tree.round(2)]
      end

    @fruit_sizes = ProductionRecord.joins(:block).select("SUM(C90)   AS C90, \
                                                          SUM(C8590) AS C8590, \ 
                                                          SUM(C7580) AS C7580, \
                                                          SUM(C7275) AS C7275, \
                                                          SUM(C7072) AS C7072, \
                                                          SUM(C6870) AS C6870, \
                                                          SUM(C6568) AS C6568, \
                                                          SUM(C65) AS C65") \
                                                 .where(block_id: @blocks) \
                                                 .group("block.accession_id")

    #@search.build_condition

    @url_report = summary_report_accessions_path

    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = AccessionSummaryReport.new(@search.result)
        send_data pdf.render, filename: 'accessions_summary_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accession
      @accession = Accession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accession_params
      params.require(:accession).permit(:name, :commercial_name, :clon_name, :synonims, :oldcode, :species_id, :group_id)
    end

end
