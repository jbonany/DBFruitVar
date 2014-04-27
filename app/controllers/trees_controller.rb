class TreesController < ApplicationController
  before_action :set_tree, only: [:show, :edit, :update, :destroy]
  
  # GET /trees
  # GET /trees.json
  def index
   
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Tree.per_page 
    end
    
    @search = Tree.ransack(params[:q])
    @trees = @search.result.paginate(:page => params[:page], :per_page => @per_page)

    respond_to do |format|
      format.html
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = TreeReport.new(@search.result)
        send_data pdf.render, filename: 'trees_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end

  # GET /trees/1
  # GET /trees/1.json
  def show
  end

  # GET /trees/new
  def new
    @tree = Tree.new
  end

  # GET /trees/1/edit
  def edit
  end

  # POST /trees
  # POST /trees.json
  def create
    @tree = Tree.new(tree_params)

    respond_to do |format|
      if @tree.save
        format.html { redirect_to @tree, notice: 'Tree was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tree }
      else
        format.html { render action: 'new' }
        format.json { render json: @tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trees/1
  # PATCH/PUT /trees/1.json
  def update
    respond_to do |format|
      if @tree.update(tree_params)
        format.html { redirect_to @tree, notice: 'Tree was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trees/1
  # DELETE /trees/1.json
  def destroy
    @tree.destroy
    respond_to do |format|
      format.html { redirect_to trees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tree
      @tree = Tree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tree_params
      params.require(:tree).permit(:tree, :row, :planting_date, :pullout_date, :rootstock, :oldcode, :oldaccessioncode, :oldcollectioncode, :block_id)
    end

end
