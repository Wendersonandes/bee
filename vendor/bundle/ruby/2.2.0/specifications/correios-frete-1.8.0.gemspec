# -*- encoding: utf-8 -*-
# stub: correios-frete 1.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "correios-frete".freeze
  s.version = "1.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Prodis a.k.a. Fernando Hamasaki".freeze]
  s.date = "2012-08-09"
  s.description = "Calculo de frete utilizando o Web Service dos Correios (http://www.correios.com.br/webservices).\nOs servicos de frete suportados sao PAC, SEDEX, SEDEX a Cobrar, SEDEX 10, SEDEX Hoje e e-SEDEX.".freeze
  s.email = ["prodis@gmail.com".freeze]
  s.homepage = "http://prodis.blog.br/correios-frete-gem-para-calculo-de-frete-dos-correios".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "2.6.10".freeze
  s.summary = "Calculo de frete dos Correios.".freeze

  s.installed_by_version = "2.6.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<log-me>.freeze, ["~> 0.0.4"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.5"])
      s.add_runtime_dependency(%q<sax-machine>.freeze, ["~> 0.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.11"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1.8"])
    else
      s.add_dependency(%q<log-me>.freeze, ["~> 0.0.4"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.5"])
      s.add_dependency(%q<sax-machine>.freeze, ["~> 0.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.11"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1.8"])
    end
  else
    s.add_dependency(%q<log-me>.freeze, ["~> 0.0.4"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.5"])
    s.add_dependency(%q<sax-machine>.freeze, ["~> 0.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.11"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.8"])
  end
end
