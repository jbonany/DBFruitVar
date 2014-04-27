class BlocksController < ApplicationController
  before_action :set_block, only: [:show, :edit, :update, :destroy]
  
  # GET /blocks
  # GET /blocks.json
  def index
    
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Country.per_page 
    end
    
    @search = Block.filtered_by_collection(session[:selected_collection]).ransack(params[:q])
    @blocks = @search.result.paginate(:page => params[:page], :per_page => @per_page)

    respond_to do |format|
      format.html
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = BlockReport.new(@search.result)
        send_data pdf.render, filename: 'blocks_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end

  # GET /blocks
  # GET /blocks.json
  def select
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Block.per_page 
    end
    
    @search = Block.filtered_by_collection(session[:selected_collection]).ransack(params[:q])
    @blocks = @search.result.paginate(:page => params[:page], :per_page => @per_page)
  end

  # GET /blocks/1
  # GET /blocks/1.json
  def show

  end

  # GET /blocks/1
  # GET /blocks/1.json
  def showphenology
    @block = Block.find(params[:id])
  
    @search_phenology = @block.phenology_records.ransack(params[:q])
    @phenology_records = @search_phenology.result.paginate(:page => params[:page], :per_page => @per_page)

    @search_production = @block.phenology_records.ransack(params[:q])
    @production_records = @search_production.result.paginate(:page => params[:page], :per_page => @per_page)
  
  end
 
  # GET /blocks/new
  def new
    @block = Block.new
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks
  # POST /blocks.json
  def create
    @block = Block.new(block_params)

    respond_to do |format|
      if @block.save
        format.html { redirect_to @block, notice: 'Block was successfully created.' }
        format.json { render action: 'show', status: :created, location: @block }
      else
        format.html { render action: 'new' }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blocks/1
  # PATCH/PUT /blocks/1.json
  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to @block, notice: 'Block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.json
  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to blocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def block_params
      params.require(:block).permit(:row, :first_tree, :last_tree, :tree_number, :planting_date, :pullout_date, :collection_id, :accession_id)
    end

end
