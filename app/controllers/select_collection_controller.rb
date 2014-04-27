class SelectCollectionController < ApplicationController

  def select
  	
  	session[:selected_collection] = params[:select_collection]
  	if session[:selected_collection] != "None"
		flash[:alert] = "Database filtered by collection " + Collection.find(session[:selected_collection].to_i).name + " !"
	else
		flash[:alert] = "Database not filtered by any collection"
	end

  end

end
