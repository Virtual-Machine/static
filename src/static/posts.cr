module Static
	class Posts
	  @@posts = YAML.parse File.read("./posts/posts.yml")
	  @@active : Hash(YAML::Type, YAML::Type) = {} of YAML::Type => YAML::Type

	  def self.posts
	    @@posts
	  end

	  def self.setActive(hash : Hash(YAML::Type, YAML::Type))
	  	@@active = hash
	  end

	  def self.active
	  	@@active
	  end
	end
end