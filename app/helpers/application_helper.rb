module ApplicationHelper
  
  def main_menu_item_for(path, text, alt, img_name)
    if current_page?(path)
      link_to content_tag(:strong, image_tag("/images/nav/#{img_name}", alt: alt) + " #{text}"), path
    else
      link_to image_tag("/images/nav/#{img_name}", alt: alt) + " #{text}", path
    end
  end

end
