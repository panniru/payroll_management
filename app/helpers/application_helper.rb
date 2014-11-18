module ApplicationHelper

  def save_button
    button_tag(:type => "submit", class: "btn btn-primary") do
      raw "<i class='fa fa-save fa-lg'></i> Save"
    end
  end

  def submit_search
    button_tag(:type => "submit", class: "btn btn-primary") do
      raw "<i class='fa fa-search fa-lg'></i> Go"
    end
  end

  def link_to_new(path, params = {})
    link_to raw("<i class='fa fa-plus-circle fa-lg'></i> New #{params['label']}"), path, :class => "btn #{params['class'].present? ? params['class'] : 'btn-primary'}"
  end

  def link_to_upload(path, params = {})
    link_to raw("<i class='fa fa-upload fa-lg'></i> Upload #{params['label']}"), path, :class => "btn #{params['class'].present? ? params['class'] : 'btn-primary'}"
  end


  def submit_link
    link_to raw("<i class='fa fa-save fa-lg'></i> Save"), "#", :class => "btn #{params[:class].present? ? params[:class] : 'btn-primary'}", :rel => "submitLink"
  end

  def edit_button(path, params={})
    link_to raw("<i class='fa fa-edit fa-lg'></i> Edit"), path, :class => "btn #{params[:class].present? ? params[:class] : 'btn-primary'}"
  end

  def delete_button(path, params={})
    link_to raw("<i class='fa fa-trash fa-lg'></i> Delete"), path, :class => "btn #{params[:class].present? ? params[:class] : 'btn-primary'}", :method => "delete", :data => {:confirm => "Are you sure?"}
  end
  
  def title(*parts)
    unless parts.empty?
      content_for :title do
        parts.join(" - ") unless parts.empty?
      end
    end
  end

end
