# -*- encoding: utf-8 -*-
# stub: sax-machine 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sax-machine".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Paul Dix".freeze, "Julien Kirch".freeze]
  s.date = "2011-09-30"
  s.email = "paul@pauldix.net".freeze
  s.homepage = "http://github.com/pauldix/sax-machine".freeze
  s.rubygems_version = "2.6.10".freeze
  s.summary = "Declarative SAX Parsing with Nokogiri".freeze

  s.installed_by_version = "2.6.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["> 0.0.0"])
    else
      s.add_dependency(%q<nokogiri>.freeze, ["> 0.0.0"])
    end
  else
    s.add_dependency(%q<nokogiri>.freeze, ["> 0.0.0"])
  end
end
