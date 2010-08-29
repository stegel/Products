class CategoryPage < Page

	desc %{
		list all categories with links to subcategory page
	}
  def child_url(child)
	

    clean_url "#{ url }/"
  end

def find_by_url(url, live = true, clean = false)
    url = clean_url(url) if clean
    if url =~ %r{^#{ self.url }(\d{1,6})/?$}
      children.find_by_class_name('ProductPage')
    else
      super
    end
  end
end

