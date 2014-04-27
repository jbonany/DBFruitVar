class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
 
  # GET /collections
  # GET /collections.json
  def index
    
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Collection.per_page 
    end
    
    @search = Collection.filtered_by_collection(session[:selected_collection]).ransack(params[:q])
    @collections = @search.result.paginate(:page => params[:page], :per_page => @per_page)

    respond_to do |format|
      format.html
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = CollectionReport.new(@search.result)
        send_data pdf.render, filename: 'collections_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end


  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render action: 'show', status: :created, collection: @collection }
      else
        format.html { render action: 'new' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url }
      format.json { head :no_content }
    end
  end

  def report
  
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = Location.per_page 
    end
    
    @search = Collection.filtered_by_collection(session[:selected_collection]).ransack(params[:q])
    @search.build_grouping unless @search.groupings.any?
    @collections = @search.result.paginate(:page => params[:page], :per_page => @per_page)
    #@search.build_condition

    @url_report = report_collections_path

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @search.result.to_csv }
      format.xls { send_data @search.result.to_csv(col_sep: "\t") }
      format.pdf do
        pdf = CollectionReport.new(@search.result)
        send_data pdf.render, filename: 'collections_report.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end

  def map

    @search = Collection.filtered_by_collection(session[:selected_collection]).ransack(params[:q])
    @search.build_grouping unless @search.groupings.any?
    @collections = Collection.filtered_by_collection(session[:selected_collection])

    respond_to do |format|
     format.html
     format.json
     format.pdf do
        pdf = CollectionMapReport.new(@search.result)
        send_data pdf.render, filename: 'collections_map.pdf', type: 'application/pdf', disposition: 'inline'
      end 
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:name, :row_distance, :tree_distance, :location_id, :species_id)
    end

end
