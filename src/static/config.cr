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