require 'csv'


### import category
CSV.foreach('categories.csv') do |row|
  Category.create!(id: row[0], name: row[2])
end

### import posts
CSV.foreach('posts.csv') do |row|
  row = row.map{|element| element == nil ? "": element}
  Post.create!(id: row[0], title: row[1], description: row[2], content: row[3], fakeimage: row[5], created_at: row[9], updated_at: row[10])
end

### import category and posts relationship
CSV.foreach('posts_categories.csv') do |row|
  begin
    post = Post.find(row[1])
    category = Category.find(row[2])
    post.categories << category unless post.categories.include? category
    post.save
  rescue
    puts row
  end
end
