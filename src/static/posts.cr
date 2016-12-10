class Posts
  @@posts = YAML.parse File.read("./posts/posts.yml")

  def self.posts
    @@posts
  end
end