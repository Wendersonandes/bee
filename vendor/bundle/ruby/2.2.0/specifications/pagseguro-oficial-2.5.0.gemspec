# -*- encoding: utf-8 -*-
# stub: pagseguro-oficial 2.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "pagseguro-oficial".freeze
  s.version = "2.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nando Vieira".freeze]
  s.date = "2016-02-23"
  s.description = "Biblioteca oficial de integra\u{e7}\u{e3}o via API com o PagSeguro".freeze
  s.email = ["fnando.vieira@gmail.com".freeze]
  s.homepage = "http://www.pagseguro.com.br".freeze
  s.licenses = ["ASL".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.6.10".freeze
  s.summary = "Biblioteca de integra\u{e7}\u{e3}o com o PagSeguro".freeze

  s.installed_by_version = "2.6.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<aitch>.freeze, ["~> 0.2"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.6"])
      s.add_runtime_dependency(%q<i18n>.freeze, ["~> 0.7"])
      s.add_runtime_dependency(%q<json>.freeze, ["~> 1.8"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<fakeweb>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<activesupport>.freeze, ["~> 4.0"])
    else
      s.add_dependency(%q<aitch>.freeze, ["~> 0.2"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.6"])
      s.add_dependency(%q<i18n>.freeze, ["~> 0.7"])
      s.add_dependency(%q<json>.freeze, ["~> 1.8"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<fakeweb>.freeze, ["~> 1.3"])
      s.add_dependency(%q<activesupport>.freeze, ["~> 4.0"])
    end
  else
    s.add_dependency(%q<aitch>.freeze, ["~> 0.2"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.6"])
    s.add_dependency(%q<i18n>.freeze, ["~> 0.7"])
    s.add_dependency(%q<json>.freeze, ["~> 1.8"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<fakeweb>.freeze, ["~> 1.3"])
    s.add_dependency(%q<activesupport>.freeze, ["~> 4.0"])
  end
end
