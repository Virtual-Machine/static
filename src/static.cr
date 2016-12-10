require "markdown"
require "yaml"
require "kemal"

class Config
  YAML.mapping(
    title: String,
    description: String,
    port: Int32,
    auto_gen_startup: Bool,
  )

  @@config = Config.from_yaml File.read "config.yml"

  def self.generate
    @@config.auto_gen_startup
  end

  def self.description
    @@config.description
  end

  def self.port
    @@config.port
  end

  def self.title
    @@config.title
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

def generateIndex : Nil
  index = render "views/index.ecr"
  File.write("build/index.html", index)
end

def generatePosts : Nil
  post = {} of String => String
  contents = ""
  Posts.posts.each do |_post|
    _post = _post.as_h.as(Hash)
    if _post.has_key? "file"
      post = _post
      contents = File.read(_post["file"].as(String))
      name = /posts\/(.*)\.md/.match(_post["file"].as(String)).try &.[1]
      if name.not_nil!
        postRender = render "views/post.ecr"
        File.write("build/post/#{name}.html", postRender)
      end
    end
  end
end

def removeOldPosts : Nil
  postDir = Dir.open("build/post")
  postDir.each do |postFile|
    if postFile.index(".html")
      File.delete("build/post/#{postFile}")
    end 
  end
end

module Static
  if Config.generate || (ARGV.size > 0 && ARGV[0] == "generate")
    puts "Generating..."
    removeOldPosts
    generateIndex
    generatePosts
  end

  get "/" do
    theme_index
  end

  get "/post/:post" do |env|
    item = env.params.url["post"].sub ".html", ""
    post_item(item)
  end
  Kemal.run Config.port
end
