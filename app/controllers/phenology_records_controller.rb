class PhenologyRecordsController < ApplicationController
  before_action :set_phenology_record, only: [:show, :edit, :update, :destroy]
  before_filter :load_block
  
  # GET /phenology_records
  # GET /phenology_records.json
  def index
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Location.per_page 
    end
    
    @search = PhenologyRecord.ransack(params[:q])
    @phenology_records = @search.result.paginate(:page => params[:page], :per_page => @per_page)

    respond_to do |format|
      format.html
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = PhenoologyRecordReport.new(@search.result)
        send_data pdf.render, filename: 'phenology_records_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end

  # GET /phenology_records/1
  # GET /phenology_records/1.json
  def show
   @phenology_record = @block.phenology_records.find(params[:id])
  end

  # GET /phenology_records/new
  def new
    @phenology_record = @block.phenology_records.new
    @phenology_record.block_id = @block.id
  end

   # GET /phenology_records/1/edit
  def edit
    @phenology_record = @block.phenology_records.find(params[:id])
  end
  
  # POST /phenology_records
  # POST /phenology_records.json
  def create

    @phenology_record = @block.phenology_records.new(phenology_record_params)
    

    respond_to do |format|
      if @phenology_record.save
        format.html { redirect_to [@block, @phenology_record], notice: 'Phenology record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @phenology_record }
      else
        format.html { render action: 'new' }
        format.json { render json: @phenology_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phenology_records/1
  # PATCH/PUT /phenology_records/1.json
  def update

    @phenology_record = @block.phenology_records.find(params[:id])

    respond_to do |format|
      if @phenology_record.update(phenology_record_params)
        format.html { redirect_to [@block, @phenology_record], notice: 'Phenology record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @phenology_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phenology_records/1
  # DELETE /phenology_records/1.json
  def destroy
    @phenology_record = @block.phenology_records.find(params[:id])
    @phenology_record.destroy
    respond_to do |format|
      format.html { redirect_to showphenology_block_path(@block) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phenology_record
      @phenology_record = PhenologyRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phenology_record_params
      params.require(:phenology_record).permit(:year, :c3, :e2, :f2, :g, :block_id)
    end
   
    def load_block
      @block = Block.find(params[:block_id])
    end
end
