require 'csv'


### import category
CSV.foreach('categories.csv') do |row|
  Category.create!(id: row[0], name: row[2])
end

### import posts
CSV.foreach('posts.csv') do |row|
  row = row.map{|element| element == nil ? "": element}
  new_image_path = 'http://www.qilian.jp/image/'+row[5].split('/')[-1] if row[5] !=''
  Post.create!(id: row[0], title: row[1], description: row[2], content: row[3], fakeview: row[3].length/2, fakeimage: new_image_path, created_at: row[9], updated_at: row[10])
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

CSV.foreach('kubuns.csv') do |row|
  Label.create!(id: row[0], category: row[1], name: row[2])
end

CSV.foreach('calendars.csv') do |row|
  row = row.map{|element| element == nil ? "": element}
  new_image_path = 'http://www.qilian.jp/image/'+row[15].split('/')[-1] if row[15] !=''
  Job.create!(id: row[0], title: row[1], content: row[2], fakeimage: new_image_path, position: row[3], comp_name: row[5], expire_at: row[6], detail: row[7], step: row[8], target: row[9], schedule: row[10], location: row[11], num: row[12], source_url:row[14], created_at: row[16], updated_at: row[17])
end

CSV.foreach('kubun_relations.csv') do |row|
  begin
    job = Job.find(row[2])
    label = Label.find(row[3])
    job.labels << label  unless job.labels.include? label 
    job.save
  rescue
    puts row
  end
end

