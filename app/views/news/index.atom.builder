atom_feed do |feed|
  feed.title("七联咨询")
  feed.updated((@posts.first.created_at))
 
  @posts.each do |post|
    feed.entry(post, url: "http://qilian.jp/news/#{post.id}" ) do |entry|
      entry.title(post.title)
      entry.description(post.description)
 
      entry.author do |author|
        author.name("七联")
      end
    end
  end
end
