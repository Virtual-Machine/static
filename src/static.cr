require "markdown"
require "yaml"
require "kemal"
require "./static/*"

module Static
  extend self

  if Config.generate || (ARGV.size > 0 && ARGV[0] == "generate")
    puts "Generating..."
    
    removeOldPosts
    generateIndex
    generatePosts
  end

  Config.set_root "/"

  get "/" do
    root = "/"
    render "views/index.ecr", "views/layout/layout.ecr"
  end

  get "/post/:post" do |env|
    item = env.params.url["post"].sub ".html", ""
    post_item(item)
  end
  
  Kemal.run Config.port
end
