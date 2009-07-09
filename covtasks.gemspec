# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{covtasks}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Carmelo Briones"]
  s.date = %q{2009-07-09}
  s.email = %q{ryan.briones@brionesandco.com}
  s.executables = ["scmcov", "segcov"]
  s.files = ["Rakefile", "bin/segcov", "bin/scmcov", "lib/covtasks", "lib/covtasks/spec", "lib/covtasks/spec/segcov.rb", "lib/covtasks/spec/scmcov.rb"]
  s.homepage = %q{http://brionesandco.com/ryanbriones}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A collection of tasks for determining coverage in alternate workflows}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
