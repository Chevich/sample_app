module UsersHelper
  def gravatar_tag(user, options = { :size => 50 })
    gravatar_image_tag user.email, :class => "gravatar", 
        :alt => user.name.capitalize+' avatar',
        :gravatar => options
  end 

end
