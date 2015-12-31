json.total_page @total_page
json.current_page @page
json.category_name @category_name if @category_name
json.posts do
  json.array! @posts do |post| 
    json.tag post.categories
    json.body post
  end
end
