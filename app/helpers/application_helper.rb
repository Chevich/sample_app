# coding: utf-8
module ApplicationHelper
  # Return a title on a per-page basis.
  def logo
    image_tag("logo.jpeg", :alt => "Sample App", :class => "round") 
  end  

  def title123
    base_title = "Твиттер-шмиттер"
    if @title.nil?
      "#{base_title}"
    else
      "#{base_title} | #{@title}"
    end
  end
end