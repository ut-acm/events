# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "parsi-date"
  s.version = "0.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hassan Zamani"]
  s.date = "2014-01-12"
  s.description = "A Solar Hijri (Jalali) date library for Ruby, whitch provides much of Ruby's built-in date class"
  s.email = "hsn.zamani@gmail.com"
  s.homepage = "http://github.com/hzamani/parsi-date"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Solar Hijri (Jalali, Persian, Parsi) date library for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.4"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.4"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.4"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
  end
end
