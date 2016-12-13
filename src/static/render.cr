module Static
	def post_item(file)
	  post = {} of String => String
	  contents = ""
	  Posts.posts.each do |_post|
	    _post = _post.as_h.as(Hash)
	    if _post.has_key? "file"
	      if (_post["file"].as(String)).ends_with?("#{file}.md")
	        Posts.setActive _post
	        contents = File.read(_post["file"].as(String))
	      end
	    end
	  end
	  render "views/post.ecr", "views/layout/layout.ecr"
	end

	def generateIndex : Nil
	  index = render "views/index.ecr", "views/layout/layout.ecr"
	  File.write("build/blog-index.html", index)
	end

	def generatePosts : Nil
	  post = {} of String => String
	  contents = ""
	  Posts.posts.each do |_post|
	    _post = _post.as_h.as(Hash)
	    if _post.has_key? "file"
	      Posts.setActive _post
	      contents = File.read(_post["file"].as(String))
	      name = /posts\/(.*)\.md/.match(_post["file"].as(String)).try &.[1]
	      if name.not_nil!
	        postRender = render "views/post.ecr", "views/layout/layout.ecr"
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
end