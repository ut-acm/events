# -*- encoding: utf-8 -*-
# stub: non-stupid-digest-assets 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "non-stupid-digest-assets"
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Alex Speller"]
  s.date = "2014-02-12"
  s.description = "    Rails 4, much to everyone's annoyance, provides no option to generate both digest\n    and non-digest assets. Installing this gem automatically creates both digest and\n    non-digest assets which are useful for many reasons. See this issue for more details:\n    https://github.com/rails/sprockets-rails/issues/49\n"
  s.email = ["alex@alexspeller.com"]
  s.homepage = "http://github.com/alexspeller/non-stupid-digest-assets"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Fix the Rails 4 asset pipeline to generate non-digest along with digest assets"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version
end
