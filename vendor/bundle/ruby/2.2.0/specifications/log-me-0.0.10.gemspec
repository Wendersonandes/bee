# -*- encoding: utf-8 -*-
# stub: log-me 0.0.10 ruby lib

Gem::Specification.new do |s|
  s.name = "log-me".freeze
  s.version = "0.0.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Prodis a.k.a. Fernando Hamasaki de Amorim".freeze]
  s.date = "2015-12-15"
  s.description = "LogMe is a simple way to configure log in your spec. It is especially useful when you need to log Web Service calls or HTTP requests and responses.".freeze
  s.email = ["prodis@gmail.com".freeze]
  s.homepage = "http://github.com/prodis/log-me".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.10".freeze
  s.summary = "A simple way to configure log in your spec.".freeze

  s.installed_by_version = "2.6.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4"])
    else
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
    end
  else
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
  end
end
