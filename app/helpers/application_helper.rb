# coding: utf-8
module ApplicationHelper
  # Return a title on a per-page basis.
  @@main_title = "Твиттер-шмиттер"

  def logo
    image_tag("logo.png", :alt => @@main_title, :class => "round")
  end  

  def title123
    if @title.nil?
      "#{@@main_title}"
    else
      "#{@@main_title} | #{@title}"
    end
  end

  def project_name
    @@main_title
  end
end