require "markdown"
require "yaml"
require "kemal"

class Config
  @@title = "Blog Title"

  def self.title
    @@title
  end
end

class Posts
  @@posts = YAML.parse File.read("./posts/posts.yml")

  def self.posts
    @@posts
  end
end

def theme_style(path)
  "/css/#{path}"
end

def theme_script(path)
  "/js/#{path}"
end

def theme_item(post, contents)
  render "views/post.ecr"
end

def theme_index
  render "views/index.ecr"
end

def post_item(file)
  post = {} of String => String
  contents = ""
  Posts.posts.each do |_post|
    puts _post
    _post = _post.as_h.as(Hash)
    if _post.has_key? "file"
      if (_post["file"].as(String)).ends_with?("#{file}.md")
        post = _post
        contents = File.read(_post["file"].as(String))
      end
    end
  end
  theme_item(post, contents)
end

module Static
  get "/" do
    theme_index
  end

  get "/post/:post" do |env|
    post_item(env.params.url["post"])
  end
  Kemal.run
end
