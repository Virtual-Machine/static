module Static
  class Config
    YAML.mapping(
      title: String,
      description: String,
      port: Int32,
      auto_gen_startup: Bool,
      disqus_shortname: String,
      logo: String,
      root: String,
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

    def self.disqus_shortname
      @@config.disqus_shortname
    end

    def self.logo
      @@config.logo
    end

    def self.root
      @@config.root
    end

    def self.set_root(root : String)
      @@config.root = root
    end
  end
end