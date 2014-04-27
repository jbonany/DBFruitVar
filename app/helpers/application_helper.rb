module ApplicationHelper
	
	def sortable(column, title = nil)
	  
	  title ||= column.titleize
	  
	  if column == sort_column then
	  	if sort_direction == "asc" then
	  		css_class = "glyphicon glyphicon-arrow-up"
	  	else
	  		css_class = "glyphicon glyphicon-arrow-down"
	  	end
	  else
	  	css_class = nil
	  end

	  direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
	  link_to (title + ' ' + content_tag(:i, "", class: css_class)).html_safe, params.merge(:sort => column, :direction => direction, :page => nil) 
	  	
	end

	def setup_search_form(builder)
	    fields = builder.grouping_fields builder.object.new_grouping,
	      object_name: 'new_object_name', child_index: "new_grouping" do |f|
	      	render('grouping_fields', f: f)
	    end
	    content_for :document_ready, %Q{
	      var search = new Search({grouping: "#{escape_javascript(fields)}"});
	      $(document).on("click", "button.add_fields", function() {
	        search.add_fields(this, $(this).data('fieldType'), $(this).data('content'));
	        return false;
	      });
	      $(document).on("click", "button.remove_fields", function() {
	        search.remove_fields(this);
	        return false;
	      });
	      $(document).on("click", "button.nest_fields", function() {
	        search.nest_fields(this, $(this).data('fieldType'));
	        return false;
	      });
	    }.html_safe
  	end

	def button_to_remove_fields(name, f)
		content_tag :button, name, class: 'remove_fields btn btn-xs'
	end

  	def button_to_add_fields(name, f, type)
	    new_object = f.object.send "build_#{type}"
	    fields = f.send("#{type}_fields", new_object, child_index: "new_#{type}") do |builder|
	      render(type.to_s + "_fields", f: builder)
	    end
	    content_tag :button, name, :class=> 'add_fields btn btn-xs', :style =>'margin: 3px;', 'data-field-type' => type, 'data-content' => "#{fields}"
	   
  	end

  	def button_to_nest_fields(name, type)
    	content_tag :button, name, :class => 'nest_fields btn btn-xs', 'data-field-type' => type
  	end
end


