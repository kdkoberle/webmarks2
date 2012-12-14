module UsersHelper
  def form_text
    if logged_in?
      "Edit Profile"
    else
      "Create Account"
    end
  end
  
  def search_box
    form_tag("/search", :method => "get") do
      label_tag(:q, "Search:")
      text_field_tag(:q)
      submit_tag("Search")
    end
  end
end
