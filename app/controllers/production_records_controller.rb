class ProductionRecordsController < ApplicationController
  before_action :set_production_record, only: [:show, :edit, :update, :destroy]
  before_filter :load_block
   
  # GET /production_records
  # GET /production_records.json
  def index
  
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Location.per_page 
    end
    
    @search = ProductionRecord.filtered_by_collection(session[:selected_collection]).ransack(params[:q])
    @production_records = @search.result.paginate(:page => params[:page], :per_page => @per_page)

    respond_to do |format|
      format.html
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = ProductionRecordReport.new(@search.result)
        send_data pdf.render, filename: 'production_records_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end

  # GET /production_records/1
  # GET /production_records/1.json
  def show
    @production_record = @block.production_records.find(params[:id])
  end

  # GET /production_records/new
  def new
    @production_record = @block.production_records.new
    @production_record.block_id = @block.id
  end

  # GET /production_records/1/edit
  def edit
    @production_record = @block.production_records.find(params[:id])
  end

  # POST /production_records
  # POST /production_records.json
  def create
    
    @production_record = @block.production_records.new(production_record_params)

    respond_to do |format|
      if @production_record.save
        format.html { redirect_to [@block, @production_record], notice: 'Production record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @production_record }
      else
        format.html { render action: 'new' }
        format.json { render json: @production_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /production_records/1
  # PATCH/PUT /production_records/1.json
  def update

    @production_record = @block.production_records.find(params[:id])

    respond_to do |format|
      if @production_record.update(production_record_params)
        format.html { redirect_to [@block, @production_record], notice: 'Production record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @production_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /production_records/1
  # DELETE /production_records/1.json
  def destroy
    @phenology_record = @block.production_records.find(params[:id])
    @production_record.destroy
    respond_to do |format|
      format.html { redirect_to showphenology_block_path(@block) }
      format.json { head :no_content }
    end
  end

  # GET /production_records
  # GET /production_records.json
  def report
  
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Location.per_page 
    end
    
    @search = ProductionRecord.filtered_by_collection(session[:selected_collection]).ransack(params[:q])
    @search.build_grouping unless @search.groupings.any?
    @production_records = @search.result.paginate(:page => params[:page], :per_page => @per_page)
    #@search.build_condition

    @url_report = report_production_records_path
    @select_associations = ["block"]

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = ProductionRecordReport.new(@search.result)
        send_data pdf.render, filename: 'production_records_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production_record
      @production_record = ProductionRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_record_params
      params.require(:production_record).permit(:harvest_date, :tree_number, :production, :c90, :c8590, :c8085, :c80, :c7580, :c7275, :c7072, :c6870, :c6568, :c65, :c6065, :c5560, :c55, :block_id)
    end

    def load_block
      if params[:block_id]
        @block = Block.find(params[:block_id])
      else
        @block = nil
      end
    end
end
