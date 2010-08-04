module VideosHelper
  def display_presenters_with_links video
    out = ""
    video.presenters.each do | presenter |
      out += link_to_unless_current(presenter.display_name, presenter_path(presenter)) + ", "
    end
    out = out [0,out.length-2]
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do | builder |
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => "add-new")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def display_video_attributes video
    render :partial => 'videos/attributes', :locals => {:video => video }
  end
end
