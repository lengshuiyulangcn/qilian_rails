Post.all.each do |post|
  fakeimage = post.fakeimage
  content = post.content
  unless post.fakeimage.nil?
    post.fakeimage = fakeimage.gsub("qilian.jp","qilian.info")
  end
  post.content = content.gsub("qilian.jp","qilian.info")
  post.save
end
