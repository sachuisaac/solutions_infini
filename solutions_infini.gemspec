Gem::Specification.new do |s|
  s.name        = 'solutions_infini'
  s.version     = '0.0.0'
  s.date        = '2015-05-20'
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Wrapper for Solutions Infini REST APIs"
  s.description = "Wrapper for Solutions Infini REST APIs using HTTParty"
  s.authors     = ["Sandeep Sreenath"]
  s.email       = 'sandeep.sreenath@gmail.com'
  #s.homepage    =
  #  'http://rubygems.org/gems/hola'
  s.license       = 'MIT'
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
  s.add_runtime_dependency 'httparty', '~> 0.9', '>= 0.9.0'
end
