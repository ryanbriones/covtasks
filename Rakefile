require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = 'covtasks'
  s.version = '0.0.1'
  s.summary = 'A collection of tasks for determining coverage in alternate workflows'
  s.files = FileList['[A-Z]*', 'bin/*', 'lib/**/*']
  s.has_rdoc = false
  s.bindir = 'bin'
  s.executables = ['scmcov', 'segcov']
  s.author = 'Ryan Carmelo Briones'
  s.email = 'ryan.briones@brionesandco.com'
  s.homepage = 'http://brionesandco.com/ryanbriones'
end

package_task = Rake::GemPackageTask.new(spec) {}

task :build_gemspec do
  File.open("#{spec.name}.gemspec", "w") do |f|
    f.write spec.to_ruby
  end
end

task :default => [:build_gemspec, :gem]
