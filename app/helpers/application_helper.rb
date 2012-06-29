module ApplicationHelper
  
  def main_menu_item_for(path, text, alt, img_name)
    if current_page?(path)
      link_to content_tag(:strong, image_tag("/images/nav/#{img_name}", alt: alt) + " #{text}"), path
    else
      link_to image_tag("/images/nav/#{img_name}", alt: alt) + " #{text}", path
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def formated_account_type
    dict = {
      Account::TYPE_THEATER => "Kino",
      Account::TYPE_FESTIVAL => "Festival",
    }
    dict[current_user.account.account_type]
  end

end
