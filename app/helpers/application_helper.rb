# coding: utf-8
module ApplicationHelper
  # Return a title on a per-page basis.
  @@title = "Твиттер-шмиттер"

  def logo
    image_tag("logo.png", :alt => @@title, :class => "round")
  end  

  def title123
    if @title.nil?
      "#{@@title}"
    else
      "#{@@title} | #{@title}"
    end
  end
end