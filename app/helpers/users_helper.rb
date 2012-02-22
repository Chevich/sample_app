module UsersHelper
  def gravatar_tag(user, options = { :size => 50 })
    gravatar_image_tag user.email.downcase, :class => "gravatar",
        :alt => user.name+' avatar',
        :gravatar => options
  end

end
